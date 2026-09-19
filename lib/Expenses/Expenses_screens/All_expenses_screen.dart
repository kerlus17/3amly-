import 'package:elwaqar/Customers/Customer_widgets/stat_card.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/Read_expenses_states.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/read_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_widgets.dart/add_Expense_dialog.dart';
import 'package:elwaqar/Expenses/Expenses_widgets.dart/all_Expenses.dart';
import 'package:elwaqar/core/widgets/page_header.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:elwaqar/core/widgets/app_background.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllExpensesScreen extends StatelessWidget {
  const AllExpensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primaryLight,
      body: Column(
      children: [
        const PageHeader(
          title: 'المصروفات',
          icon: Icons.receipt_long_outlined,
        ),
        Expanded(
          child: BlocBuilder<ReadExpensesCubit, ReadExpensesStates>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [_addExpenseButton(context)],
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          StatCard(
                            label: "total expenses",
                            value: (state is ReadExpensesSuccessStates
                                    ? state.expenses.length
                                    : 0)
                                .toString(),
                          ),
                          const SizedBox(width: 8),
                          StatCard(
                            label: "total price",
                            value: (state is ReadExpensesSuccessStates
                                    ? state.expenses.fold<double>(
                                        0,
                                        (sum, e) => sum + e.price,
                                      )
                                    : 0)
                                .toStringAsFixed(0),
                            background: ColorManager.errorRed.withOpacity(0.12),
                            labelColor: ColorManager.errorRed,
                            valueColor: ColorManager.errorRed,
                          ),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Expanded(child: AllExpenses()),
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

  Widget _addExpenseButton(BuildContext context) {
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
            builder: (context) => const AddExpenseDialog(),
          );
        },
        icon: const Icon(Icons.add, size: 16, color: ColorManager.white),
        label: const Text(
          'Add expense',
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
