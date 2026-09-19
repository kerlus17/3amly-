import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_cubit.dart';
import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
import 'package:elwaqar/Customers/Customer_widgets/add_customer_dialog.dart';
import 'package:elwaqar/Customers/Customer_widgets/all_customers.dart';
import 'package:elwaqar/Customers/Customer_widgets/stat_card.dart';
import 'package:elwaqar/Customers/customers_screens/screens/all_Customers_AfeterButton.dart';
import 'package:elwaqar/core/widgets/page_header.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllCustomersScreen extends StatelessWidget {
  const AllCustomersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryLight,
      body: Column(
        children: [
          const PageHeader(title: 'العملاء', icon: Icons.groups_outlined),
          Expanded(
            child: BlocBuilder<ReadCustomerCubit, ReadCustomerState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [_addCustomerButton(context)],
                      ),
                      SizedBox(height: 10),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            StatCard(
                              label: "total customer",
                              value: ReadCustomerCubit
                                  .get(context)
                                  .numberOfCustomer()
                                  .toString(),
                              background: ColorManager.primary400,
                              labelColor: ColorManager.primary800,
                              valueColor: ColorManager.primary900,
                            ),
                            SizedBox(width: 8),
                            StatCard(
                              label: "out standing",
                              value: ReadCustomerCubit.get(context)
                                  .totalOutRemining()
                                  .toString(),
                              background: ColorManager.errorRed.withOpacity(
                                0.12,
                              ),
                              labelColor: ColorManager.errorRed,
                              valueColor: ColorManager.errorRed,
                            ),
                            SizedBox(width: 8),
                            StatCard(
                              label: "depted",
                              value: ReadCustomerCubit.get(context)
                                  .totalDeptCustomers()
                                  .toString(),
                              background: ColorManager.primary600.withOpacity(
                                0.15,
                              ),
                              labelColor: ColorManager.primary900,
                              valueColor: ColorManager.primary900,
                            ),
                            SizedBox(width: 8),

                            StatCard(
                              label: "best Customer",
                              value: ReadCustomerCubit.get(
                                context,
                              ).bestCustomer(),
                              background: ColorManager.primary400.withOpacity(
                                0.35,
                              ),
                              labelColor: ColorManager.primary800,
                              valueColor: ColorManager.primary800,
                            ),
                            SizedBox(width: 8),
                          ],
                        ),
                      ),
                      const SizedBox(height: 15),
                      // إلتفاف الـ Widget بـ Expanded يحل المشكلة
                      const Expanded(child: AllCustomers()),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _addCustomerButton(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ElevatedButton.icon(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => const AddCustomerDialog(),
          );
        },
        icon: const Icon(Icons.add, size: 16, color: ColorManager.white),
        label: const Text(
          'Add customer',
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: ColorManager.white,
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorManager.primary,
          foregroundColor: ColorManager.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
          minimumSize: const Size(0, 32),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    );
  }
}

Widget _showCustomersButton(BuildContext context) {
  return ElevatedButton.icon(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return AllCustomersAfeterbutton();
          },
        ),
      );
    },
    icon: const Icon(Icons.add, size: 16, color: ColorManager.white),
    label: const Text(
      'Add customer',
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w500,
        color: ColorManager.white,
      ),
    ),
    style: ElevatedButton.styleFrom(
      backgroundColor: ColorManager.primary,
      foregroundColor: ColorManager.white,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
      minimumSize: const Size(0, 32),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  );
}
