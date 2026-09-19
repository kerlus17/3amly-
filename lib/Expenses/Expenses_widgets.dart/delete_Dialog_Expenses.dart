import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/read_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_write_cubit/write_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_write_cubit/write_expenses_states.dart';
import 'package:elwaqar/Expenses/Expenses_model/expenses_model.dart';
import 'package:elwaqar/core/constants/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:elwaqar/style/color_manager.dart';

class DeleteDialogExpenses extends StatefulWidget {
  final ExpenseModel expense;

  const DeleteDialogExpenses({super.key, required this.expense});

  @override
  State<DeleteDialogExpenses> createState() => _AddTransactionDialogState();
}

class _AddTransactionDialogState extends State<DeleteDialogExpenses> {
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WriteExpensesCubit, WriteExpensesStates>(
      listener: (context, state) {
        if (state is WriteExpensesErrorStates) {
          setState(() => _isDeleting = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.msg.isNotEmpty ? state.msg : "فشل حذف المصروف",
                textDirection: TextDirection.rtl,
              ),
              backgroundColor: ColorManager.errorRed,
            ),
          );
        } else if (state is WriteExpensesSuccessStates) {
          ReadExpensesCubit.get(context).getExpenses();
          Navigator.of(context).pop();
        }
      },
      builder: (context, state) {
        return Dialog(
          backgroundColor: ColorManager.transparent,
          insetPadding: const EdgeInsets.all(16),
          child: Container(
            width: 380,
            padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 20),
            decoration: BoxDecoration(
              color: ColorManager.primary900,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: ColorManager.primary700, width: 0.5),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  CupertinoIcons.exclamationmark_triangle,
                  color: ColorManager.errorRed,
                  size: 30,
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        "ازاله (${widget.expense.name})",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 28),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Custombutton(
                      icon: _isDeleting
                          ? CupertinoIcons.hourglass
                          : CupertinoIcons.trash,
                      txt: "متاكد",
                      onPressed: _isDeleting
                          ? () {}
                          : () {
                              setState(() => _isDeleting = true);
                              WriteExpensesCubit.get(context)
                                  .deleteExpense(widget.expense.indexAtDatabase);
                            },
                    ),
                    SizedBox(width: 15),
                    Custombutton(
                      icon: CupertinoIcons.xmark,
                      txt: "تراجع",
                      onPressed: _isDeleting
                          ? () {}
                          : () {
                              Navigator.pop(context);
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}