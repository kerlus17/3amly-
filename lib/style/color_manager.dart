import 'dart:ui';

/// لوحة ألوان "دفتر" — كل الألوان المستخدمة في التطبيق يجب أن تأتي من هذا
/// الملف فقط، حتى تبقى الهوية البصرية متناسقة في كل الشاشات.
///
/// الألوان الستة الأساسية هي بالضبط ألوان لوحة المرجع:
///   #2b2e33  #3c2f28  #4b473f  #6a5a45  #7d6f5a  #a58c72
abstract class ColorManager {
  // ================= الألوان الستة الأساسية (من لوحة المرجع) =================
  static const Color primary900 = Color(0xFF2B2E33); // #2b2e33 — الأغمق (حبر/عناوين)
  static const Color primary800 = Color(0xFF3C2F28); // #3c2f28 — بني غامق (اللون الأساسي)
  static const Color primary700 = Color(0xFF4B473F); // #4b473f — بني زيتوني
  static const Color primary600 = Color(0xFF6A5A45); // #6a5a45 — بني متوسط
  static const Color primary500 = Color(0xFF7D6F5A); // #7d6f5a — تان زيتوني
  static const Color primary400 = Color(0xFFA58C72); // #a58c72 — تان فاتح (الأفتح في اللوحة)

  // ================= ألوان مساعدة تقنية بحتة (بلا لون فعلي) =================
  static const Color transparent = Color(0x00000000);

  // ================= لون تنبيه/خطأ منسجم مع الطابع العتيق =================
  // بني-أحمر عتيق مشتق من نفس عائلة الباليت بدل الأحمر الصريح، يُستخدم فقط
  // لحالات الخطأ/الديون السالبة حتى تبقى واضحة دلاليًا دون كسر الهوية.
  static const Color errorRed = Color(0xFF8C3B2E);
  static const Color successTone = Color.fromARGB(255, 36, 38, 42); // للحالات الإيجابية (مدفوع بالكامل...)

  // ================= أسطح فوق خلفية الورق (Overlays) =================
  // تُستخدم للهيدر/البطاقات/الحوارات بدل الأبيض الصلب، حتى تظهر خامة
  // الورق دائمًا خلف كل عنصر شبه شفاف.
  static const Color surface = Color(0xE6A58C72); // primary400 بشفافية ~90%
  static const Color surfaceStrong = Color(0xF2A58C72); // primary400 أقل شفافية (للهيدر)
  static const Color surfaceSoft = Color(0x33A58C72); // primary400 شفافة جدًا (تظليل خفيف)
  static const Color hairline = Color(0x333C2F28); // primary800 شفاف — حدود رفيعة
  static const Color divider = Color(0x1F2B2E33); // primary900 شفاف جدًا — فواصل

  // ================= أسماء مستعارة متوافقة مع الكود الحالي =================
  static const Color primary = primary800; // الأزرار الأساسية والعناصر النشطة
  static const Color primaryDark = primary900; // نصوص العناوين الغامقة
  static const Color primaryLight = Color.fromARGB(255, 185, 176, 167); // النصوص/الحدود الفاتحة فوق الأسطح الغامقة

  static const Color black = primary900; // بديل عن Colors.black
  static const Color white = Color.fromARGB(255, 216, 210, 204); // بديل عن Colors.white (فاتح، وليس أبيض صلب)
  static const Color red = errorRed; // بديل عن Colors.red

  static const Color splashBlack = primary900;
  static const Color splashBrownDark = primary800;
  static const Color splashBrown = primary700;
  static const Color splashOlive = primary600;
  static const Color splashGold = primary500;
  static const Color splashCream = primary400;
}
