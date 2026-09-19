abstract class WriteCustomerState {}

class WriteCustomerInitialState extends WriteCustomerState {}

class WriteCustomerLoadingState extends WriteCustomerState {}

class WriteCustomerSuccessState extends WriteCustomerState {}

class WriteCustomerErrorState extends WriteCustomerState {
  final String errorMessage;
  WriteCustomerErrorState(this.errorMessage);
}