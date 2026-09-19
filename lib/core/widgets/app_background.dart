import 'package:flutter/material.dart';
import 'package:elwaqar/style/color_manager.dart';

/// خلفية الورق العتيق الموحّدة لكل شاشات التطبيق.
///
/// لفّي أي شاشة بهذا الـ Widget بدلاً من وضع لون خلفية صلب على الـ Scaffold،
/// مع جعل `Scaffold.backgroundColor` = ColorManager.transparent، حتى تظهر خامة
/// الورق نفسها في كل صفحات المشروع بشكل موحّد.
///
/// مثال الاستخدام:
/// ```dart
/// Scaffold(
///   backgroundColor: ColorManager.transparent,
///   body: AppBackground(
///     child: Column(children: [...]),
///   ),
/// )
/// ```
class AppBackground extends StatelessWidget {
  const AppBackground({
    super.key,
    required this.child,
    this.dim = 0.0,
  });

  /// المحتوى الذي سيظهر فوق الخلفية
  final Widget child;

  /// تعتيم اختياري فوق الورق (0 = بدون تعتيم) لتحسين تباين النص في بعض
  /// الشاشات (مثل شاشة Splash عند وضع نص فاتح فوقها).
  final double dim;

  static const String assetPath = 'assets/images/backsplash.png';

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(assetPath),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (dim > 0)
            Container(color: ColorManager.black.withOpacity(dim)),
          child,
        ],
      ),
    );
  }
}
