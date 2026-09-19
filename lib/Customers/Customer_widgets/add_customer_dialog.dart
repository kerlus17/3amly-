import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customers_states.dart';
import 'package:elwaqar/Customers/Customer_widgets/Card_color_paker.dart';
import 'package:elwaqar/Customers/Customer_widgets/Custom_form_desc.dart';
import 'package:elwaqar/Customers/Customer_widgets/app_text_field.dart';
import 'package:elwaqar/Customers/Customer_widgets/done_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class AddCustomerDialog extends StatefulWidget {
  const AddCustomerDialog({super.key});

  @override
  State<AddCustomerDialog> createState() => _AddCustomerDialogState();
}

class _AddCustomerDialogState extends State<AddCustomerDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> formkey3 = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: ColorManager.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: BlocConsumer<WriteCustomerCubit, WriteCustomerState>(
        listener: (context, state) {
          if (state is WriteCustomerErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.errorMessage.isNotEmpty
                      ? state.errorMessage
                      : "Failed to add customer",
                ),
                backgroundColor: ColorManager.red,
              ),
            );
          } else if (state is WriteCustomerSuccessState) {
            ReadCustomerCubit.get(context).getCustomers();

            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: ColorManager.primary900,
            ),
            padding: const EdgeInsets.all(
              20,
            ), // 👈 تقليل الـ Padding لإعطاء مساحة أوسع للـ Form
            child: SingleChildScrollView(
              // 👈 يحمي الشاشة من الـ Overflow عند ظهور الكيبورد
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _headRow(context),
                  const SizedBox(height: 20),
                  AppTextField(formKey: formKey, label: "name of customer"),
                  const SizedBox(height: 16),
                  CustomFormDesc(formKey: formkey3, label: "description"),
                  const SizedBox(height: 20),
                  const CardColorPicker(), // 👈 حذف الـ Expanded لحل الفراغ الكبير
                  const SizedBox(height: 24),
                  Center(
                    child: DoneButton(
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          WriteCustomerCubit.get(context).addCustomer();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Row _headRow(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          decoration: BoxDecoration(
            color: ColorManager.primary,
            borderRadius: BorderRadius.circular(9),
          ),
          child: const Icon(
            Icons.person_add_outlined,
            color: ColorManager.white,
            size: 18,
          ),
        ),
        const SizedBox(width: 10),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Add customer',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: ColorManager.white,
              ),
            ),
            Text(
              'Fill in the details below',
              style: TextStyle(fontSize: 11, color: ColorManager.primary400),
            ),
          ],
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: ColorManager.primary600,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.close, color: ColorManager.primary400, size: 16),
          ),
        ),
      ],
    );
  }
}
