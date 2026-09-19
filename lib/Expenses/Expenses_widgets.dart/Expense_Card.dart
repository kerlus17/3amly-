import 'package:elwaqar/Expenses/Expenses_model/expenses_model.dart';
import 'package:elwaqar/Expenses/Expenses_widgets.dart/delete_Dialog_Expenses.dart';
import 'package:elwaqar/Expenses/Expenses_widgets.dart/edeit_expenses_dialog.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExpenseCard extends StatelessWidget {
  final ExpenseModel expense;

  const ExpenseCard({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    final initials = expense.name
        .trim()
        .split(' ')
        .take(2)
        .map((w) => w[0])
        .join();

    final dateText =
        '${expense.date.year}-${expense.date.month.toString().padLeft(2, '0')}-${expense.date.day.toString().padLeft(2, '0')}';

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.primary900,
        borderRadius: BorderRadius.circular(14),
        border: Border(
          left: BorderSide(color: ColorManager.primary400, width: 4),
        ),
        boxShadow: [
          BoxShadow(
            color: ColorManager.primary900.withOpacity(0.22),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: ColorManager.primary500,
                  child: Text(
                    initials,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: ColorManager.primary900,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expense.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: ColorManager.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        dateText,
                        style: TextStyle(
                          fontSize: 12,
                          color: ColorManager.primary400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  expense.price.toString(),
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: ColorManager.white,
                  ),
                ),
                const SizedBox(width: 10),
               
              ],
            ),

            SizedBox(height: 9,),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              
                _buttonEditOrDelete(context,() {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return DeleteDialogExpenses(expense: expense);
                      },
                    );
                  },CupertinoIcons.delete_solid),

                  SizedBox(width: 20,),

                    _buttonEditOrDelete(context,() {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return EdeitExpensesDialog(oldExpense: expense);
                      },
                    );
                  },CupertinoIcons.pencil),
            ],)
          ],
        ),
      ),
    );
  }

  Widget _buttonEditOrDelete(BuildContext context,VoidCallback fun ,IconData icondata) {
    return Expanded(
      child: InkWell(
        onTap: fun,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 2,color: ColorManager.primary400,)
                    ),
                    child: Icon(
                      icondata,
                      color: ColorManager.primary400,
                      size: 25,
                    ),
                  ),
      ),
    );
  }
}
