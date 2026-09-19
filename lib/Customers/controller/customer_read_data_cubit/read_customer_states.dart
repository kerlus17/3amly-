import 'package:elwaqar/Customers/model/customer/costumer_model.dart';

abstract class ReadCustomerState {}

class ReadCustomerInitialState extends ReadCustomerState {}

class ReadCustomerLoadingState extends ReadCustomerState {}

class ReadCustomerSuccessState extends ReadCustomerState {
  final List<CustumerModel> customers;
  

  ReadCustomerSuccessState(this.customers, );
}

class ReadCustomerErrorState extends ReadCustomerState {
  final String errorMessage;

  ReadCustomerErrorState(this.errorMessage);
}
