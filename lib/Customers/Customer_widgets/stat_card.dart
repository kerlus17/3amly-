import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color background;
  final Color labelColor;
  final Color valueColor;

  const StatCard({
    super.key,
    required this.label,
    required this.value,
    this.background = ColorManager.primary400,
    this.labelColor = ColorManager.primary800,
    this.valueColor = ColorManager.primary900,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadCustomerCubit,ReadCustomerState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: valueColor.withOpacity(0.14),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 11,
                  color: labelColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 21,
                  color: valueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
