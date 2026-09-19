import 'package:elwaqar/dashboard/dashboard_screen.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:elwaqar/core/widgets/app_background.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreens>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  );
  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOut,
  );
  late final Animation<Offset> _slideUp = Tween<Offset>(
    begin: const Offset(0, 0.08),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void initState() {
    super.initState();
    _controller.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const DashboardScreen(),
        ),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.transparent,
      body: AppBackground(
        child: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slideUp,
              child: Column(
                children: [
                  const SizedBox(height: 36),
                  Image.asset(
                    'assets/images/logo_daftar.png',
                    width: 240,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'دفتر حساباتك بين يديك',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: ColorManager.black,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const Spacer(),
                  Image.asset(
                    'assets/images/ChatGPT Image Aug 23, 2026, 01_21_17 AM.png',
                    height: 420,
                    fit: BoxFit.contain,
                  ),
                  const Spacer(flex: 2),
                  SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.4,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        ColorManager.splashBlack,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}