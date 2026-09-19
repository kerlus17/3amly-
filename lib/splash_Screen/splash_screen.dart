import 'dart:math' as math;

import 'package:elwaqar/dashboard/dashboard_screen.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';

/// Splash screen shown for 5 seconds before navigating to the home screen.
/// Black & brown palette, smooth/eye-friendly animation, "waqar" wordmark,
/// and an animated jalabiya (galabia) illustration drawn with CustomPainter
/// (no external video asset required).
class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with TickerProviderStateMixin {
  // Entrance animation: fade / scale / slide-in of the logo & text.
  late final AnimationController _entranceController;
  late final Animation<double> _entranceCurve;

  // Idle "breathing" loop: gentle sway of the galabia, glow pulse,
  // and a slow shimmer sweep across the wordmark.
  late final AnimationController _breatheController;

  @override
  void initState() {
    super.initState();

    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    )..forward();
    _entranceCurve = CurvedAnimation(
      parent: _entranceController,
      curve: Curves.easeOutCubic,
    );

    _breatheController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (_, animation, __) => const DashboardScreen(),
          transitionsBuilder: (_, animation, __, child) {
            return FadeTransition(opacity: animation, child: child);
          },
        ),
      );
    });
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _breatheController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.splashBlack,
      body: AnimatedBuilder(
        animation: Listenable.merge([_entranceController, _breatheController]),
        builder: (context, _) {
          final breathe = _breatheController.value; // 0 -> 1 -> 0
          final entrance = _entranceCurve.value; // 0 -> 1

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: const Alignment(0, -0.15),
                radius: 1.2,
                colors: [
                  Color.lerp(
                    ColorManager.splashBrownDark,
                    ColorManager.splashBrown,
                    breathe * 0.5,
                  )!,
                  ColorManager.splashBlack,
                ],
              ),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Soft ambient glow behind the illustration.
                Opacity(
                  opacity: (0.25 + breathe * 0.15) * entrance,
                  child: Container(
                    width: 260,
                    height: 260,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          ColorManager.splashGold,
                          ColorManager.transparent,
                        ],
                      ),
                    ),
                  ),
                ),

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Animated jalabiya illustration.
                    Transform.translate(
                      offset: Offset(0, (1 - entrance) * 30),
                      child: Opacity(
                        opacity: entrance,
                        child: Transform.rotate(
                          angle: math.sin(breathe * math.pi) * 0.035,
                          child: Transform.scale(
                            scale: 0.85 + entrance * 0.15,
                            child: CustomPaint(
                              size: const Size(150, 210),
                              painter: _GalabiaPainter(
                                glow: breathe,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    // "waqar" wordmark with a slow shimmer sweep.
                    Opacity(
                      opacity: entrance,
                      child: Transform.translate(
                        offset: Offset(0, (1 - entrance) * 16),
                        child: ShaderMask(
                          shaderCallback: (bounds) {
                            final sweep = breathe;
                            return LinearGradient(
                              begin: Alignment(-1.5 + sweep * 3, 0),
                              end: Alignment(-0.5 + sweep * 3, 0),
                              colors: const [
                                ColorManager.splashCream,
                                ColorManager.splashGold,
                                ColorManager.splashCream,
                              ],
                            ).createShader(bounds);
                          },
                          child: const Text(
                            'waqar',
                            style: TextStyle(
                              fontSize: 52,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 6,
                              color: ColorManager.white,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Opacity(
                      opacity: (entrance - 0.3).clamp(0.0, 1.0) / 0.7,
                      child: const Text(
                        'إدارة العملاء والمدفوعات',
                        style: TextStyle(
                          fontSize: 13,
                          color: ColorManager.splashGold,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),

                // Bottom breathing loading dots.
                Positioned(
                  bottom: 56,
                  child: Opacity(
                    opacity: entrance,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: List.generate(3, (i) {
                        final delay = i * 0.2;
                        final t = ((breathe + delay) % 1.0);
                        final dotOpacity = 0.25 + (math.sin(t * math.pi) * 0.6).abs();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: Opacity(
                            opacity: dotOpacity.clamp(0.25, 1.0),
                            child: Container(
                              width: 7,
                              height: 7,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ColorManager.splashGold,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

/// Draws a simple, elegant jalabiya (galabia) silhouette.
class _GalabiaPainter extends CustomPainter {
  final double glow; // 0 -> 1 -> 0, used for a subtle collar-embroidery pulse

  _GalabiaPainter({required this.glow});

  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    final bodyPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          ColorManager.splashBrown,
          ColorManager.splashBrownDark,
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, h));

    final outlinePaint = Paint()
      ..color = ColorManager.splashGold.withOpacity(0.55)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;

    // Main tunic body (trapezoid with a gentle curved hem).
    final body = Path()
      ..moveTo(w * 0.38, h * 0.14) // left shoulder
      ..lineTo(w * 0.62, h * 0.14) // right shoulder
      ..lineTo(w * 0.80, h * 0.95) // right hem
      ..quadraticBezierTo(w * 0.5, h * 1.0, w * 0.20, h * 0.95) // curved hem
      ..close();

    canvas.drawPath(body, bodyPaint);
    canvas.drawPath(body, outlinePaint);

    // Sleeves.
    final leftSleeve = Path()
      ..moveTo(w * 0.38, h * 0.16)
      ..lineTo(w * 0.12, h * 0.40)
      ..lineTo(w * 0.22, h * 0.46)
      ..lineTo(w * 0.40, h * 0.24)
      ..close();
    final rightSleeve = Path()
      ..moveTo(w * 0.62, h * 0.16)
      ..lineTo(w * 0.88, h * 0.40)
      ..lineTo(w * 0.78, h * 0.46)
      ..lineTo(w * 0.60, h * 0.24)
      ..close();

    canvas.drawPath(leftSleeve, bodyPaint);
    canvas.drawPath(leftSleeve, outlinePaint);
    canvas.drawPath(rightSleeve, bodyPaint);
    canvas.drawPath(rightSleeve, outlinePaint);

    // Collar / neckline (V-shape).
    final collar = Path()
      ..moveTo(w * 0.45, h * 0.14)
      ..lineTo(w * 0.50, h * 0.24)
      ..lineTo(w * 0.55, h * 0.14);
    final collarPaint = Paint()
      ..color = ColorManager.splashGold.withOpacity(0.5 + glow * 0.4)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(collar, collarPaint);

    // Front placket embroidery (a thin decorative line down the chest).
    final placket = Paint()
      ..color = ColorManager.splashGold.withOpacity(0.35 + glow * 0.25)
      ..strokeWidth = 1.4
      ..style = PaintingStyle.stroke;
    canvas.drawLine(
      Offset(w * 0.50, h * 0.24),
      Offset(w * 0.50, h * 0.58),
      placket,
    );

    // A couple of small buttons along the placket.
    final buttonPaint = Paint()
      ..color = ColorManager.splashGold.withOpacity(0.6 + glow * 0.3);
    for (final t in [0.30, 0.38, 0.46]) {
      canvas.drawCircle(Offset(w * 0.50, h * t), 1.6, buttonPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _GalabiaPainter oldDelegate) =>
      oldDelegate.glow != glow;
}