abstract class WriteExpensesStates {}

class WriteExpensesInitialStates extends WriteExpensesStates {}

class WriteExpensesLoadingStates extends WriteExpensesStates {}

class WriteExpensesSuccessStates extends WriteExpensesStates {}

class WriteExpensesErrorStates extends WriteExpensesStates {
  final String msg;
  WriteExpensesErrorStates(this.msg);
}
