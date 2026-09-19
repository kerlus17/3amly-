import 'package:elwaqar/Expenses/Expenses_model/expenses_model.dart';

abstract class ReadExpensesStates {}

class ReadExpensesInitialStates extends ReadExpensesStates {}

class ReadExpensesLoadingStates extends ReadExpensesStates {}

class ReadExpensesSuccessStates extends ReadExpensesStates {
  final List<ExpenseModel> expenses;

  ReadExpensesSuccessStates(this.expenses);
}

class ReadExpensesErrorStates extends ReadExpensesStates {
  final String msg;
  ReadExpensesErrorStates(this.msg);
}
