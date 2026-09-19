import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customers_states.dart';
import 'package:elwaqar/Customers/Customer_widgets/Color_dot.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardColorPicker extends StatefulWidget {
  const CardColorPicker({super.key});

  @override
  State<CardColorPicker> createState() => _CardColorPickerState();
}

class _CardColorPickerState extends State<CardColorPicker> {
  // ملاحظة: هذه ألوان اختيارية يختارها المستخدم لتمييز بطاقة كل عميل عن
  // الآخر بصريًا (وسم/تصنيف)، وليست ألوان هوية للتطبيق نفسه — لذلك تبقى
  // متنوعة عمدًا خارج لوحة ColorManager حتى تظل بطاقات العملاء قابلة
  // للتمييز عن بعضها. كل باقي الألوان في هذا الملف مأخوذة من ColorManager.
  final List<int> _colors = [
    0xFFD4537E,
    0xFF72243E,

    0xFF1D9E75,
    0xFF085041,

    0xFFEF9F27,

    0xFFE6F1FB,

    0xFF7F77DD,

    0xFFD85A30,

    0xFF712B13,
    0xFF0F1729,
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WriteCustomerCubit, WriteCustomerState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Card color',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                color: ColorManager.primary700,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 60,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return ColorDot(
                    color: _colors[index],
                    isSelected:
                        _colors[index] == WriteCustomerCubit.get(context).color
                        ? true
                        : false,
                    onTap: () {
                      WriteCustomerCubit.get(
                        context,
                      ).updatecolorCode(_colors[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return SizedBox(width: 5);
                },
                itemCount: _colors.length,
              ),
            ),
          ],
        );
      },
    );
  }
}
