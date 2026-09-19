import 'package:elwaqar/Customers/Customer_widgets/States_Widgets.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/Read_expenses_states.dart';
import 'package:elwaqar/Expenses/Expenses_controller/Expenses_read_cubit/read_expenses_cubit.dart';
import 'package:elwaqar/Expenses/Expenses_model/expenses_model.dart';
import 'package:elwaqar/Expenses/Expenses_widgets.dart/Expense_Card.dart';
import 'package:elwaqar/style/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AllExpenses extends StatelessWidget {
  const AllExpenses({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadExpensesCubit, ReadExpensesStates>(
      builder: (context, state) {
        if (state is ReadExpensesSuccessStates) {
          if (state.expenses.isEmpty) {
            return StatesWidgets(
              icon: Icon(Icons.air_rounded),
              txt: "there is no expenses",
            );
          } else {
            return _getCardExpense(state.expenses);
          }
        } else if (state is ReadExpensesErrorStates) {
          return StatesWidgets(
            icon: Icon(Icons.air_rounded),
            txt: state.msg,
          );
        } else {
          return CircularProgressIndicator(color: ColorManager.white);
        }
      },
    );
  }

  Widget _getCardExpense(List<ExpenseModel> expenses) {
    return ListView.separated(
      itemBuilder: (context, index) {
        return ExpenseCard(expense: expenses[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemCount: expenses.length,
    );
  }
}
