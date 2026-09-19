import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwaqar/Customers/controller/customer_write_data_cubit/write_customers_states.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WriteCustomerCubit extends Cubit<WriteCustomerState> {
  WriteCustomerCubit() : super(WriteCustomerInitialState());

  static WriteCustomerCubit get(context) => BlocProvider.of(context);

  final CollectionReference _customersRef =
      FirebaseFirestore.instance.collection("customers");


  String name = "";
  double rest = 0;
  String desc = "";
  int color = 0xFFD4537E;
  bool DeptOrNo = false;

  void updateDesc(String text) {
    this.desc = text;
    emit((WriteCustomerInitialState()));
  }

  void updatecolorCode(int colorCode) {
    this.color = colorCode;
    emit((WriteCustomerInitialState()));
  }

  void updateName(String text) {
    this.name = text;
    emit((WriteCustomerInitialState()));
  }

  void updateRest(double rest) {
    this.rest = rest;
    emit((WriteCustomerInitialState()));
  }

  void addCustomer() {
    _tryAndCatchBloc(() async {
      final newCustomer = CustumerModel(
        indexAtDatabase: '',
        debtOrNo: false,
        color: color,
        name: name.trim(),
        description: desc,
        remainingAmount: 0.0,
        paymentsHistory: [],
        transactionsHistory: [],
      );

      _customersRef.add(newCustomer.toMap());

      emit(WriteCustomerSuccessState());
    }, "Error adding customer ");
  }

  void deleteCustomer(String indexOfCutomer) {
    _tryAndCatchBloc(() async {
      if (indexOfCutomer.isEmpty) {
        throw Exception("the id is empty");
      }
      await _customersRef.doc(indexOfCutomer).delete();

      emit(WriteCustomerSuccessState());
    }, "Error deleting customer");
  }

  void edittransactionInCustomer(
    int indexTransaction,
    String customerIndex,
    String transactionName,
    double cost,
    double payed,
    double rest,
    DateTime date,
    double oldrest,
  ) {
    _tryAndCatchBloc(() async {
      final CustumerModel customer = await _getCustomerbyId(customerIndex);

      if (customerIndex.isEmpty) {
        throw Exception("Customer index is out of bounds");
      }

      CustumerModel updated = customer.editTransaction(
        indexTransaction,
        transactionName,
        cost,
        payed,
        rest,
        date,
      );

      updated.remainingAmount = customer.remainingAmount + (rest - oldrest);
      updated.debtOrNo = updated.remainingAmount > 0;

      _customersRef.doc(customerIndex).update(updated.toMap());

      emit(WriteCustomerSuccessState());
    }, "Error adding transaction to customer");
  }

  void editPaymentCustomer(
    String customerIndex,
    int indexOfPayment,
    double cost,
    DateTime date,
    double oldcost,
  ) {
    _tryAndCatchBloc(() async {
      final CustumerModel customer = await _getCustomerbyId(customerIndex);

      if (customerIndex.isEmpty) {
        throw Exception("Customer index is out of bounds");
      }

      CustumerModel updated = customer.editPayment(indexOfPayment, cost, date);

      updated.remainingAmount = customer.remainingAmount - (cost - oldcost);
      updated.debtOrNo = updated.remainingAmount > 0;

      _customersRef.doc(customerIndex).update(updated.toMap());
      emit(WriteCustomerSuccessState());
    }, "Error adding transaction to customer");
  }

  void addTransactionToCustomer(
    String customerIndex,
    String transactionName,
    double cost,
    double payed,
    double rest,
  ) {
    _tryAndCatchBloc(() async {
      if (customerIndex.isEmpty) {
        throw Exception("the id is empty");
      }

      final CustumerModel customer = await _getCustomerbyId(customerIndex);

      CustumerModel customerTarget = customer.addTransaction(
        transactionName,
        cost,
        payed,
        rest,
      );

      customerTarget.remainingAmount = customerTarget.remainingAmount + rest;
      customerTarget.debtOrNo = customerTarget.remainingAmount > 0;

      _customersRef.doc(customerIndex).update(customerTarget.toMap());

      emit(WriteCustomerSuccessState());
    }, "Error adding transaction to customer");
  }

  void deleteTransactionFromCustomer(
    String customerIndex,
    int indexOfTransaction,
  ) {
    _tryAndCatchBloc(() async {
      if (customerIndex.isEmpty) {
        throw Exception("the id is empty");
      }

      final CustumerModel customer = await _getCustomerbyId(customerIndex);

      double newremaining = customer.remainingAmount -
          customer.transactionsHistory[indexOfTransaction].rest;

      CustumerModel customerTarget = customer.deleteTransaction(
        indexOfTransaction,
      );

      customerTarget.remainingAmount = newremaining;
      customerTarget.debtOrNo = customerTarget.remainingAmount > 0;

      _customersRef.doc(customerIndex).update(customerTarget.toMap());

      emit(WriteCustomerSuccessState());
    }, "Error adding transaction to customer");
  }

  void deletePaymentFromCustomer(String customerIndex, int indexOfPayment) {
    _tryAndCatchBloc(() async {
      if (customerIndex.isEmpty) {
        throw Exception("the id is empty");
      }

      final CustumerModel customer = await _getCustomerbyId(customerIndex);
      final newRemaining = customer.remainingAmount +
          customer.paymentsHistory[indexOfPayment].amount;

      final CustumerModel targetCustomer = customer.deletePayment(
        indexOfPayment,
      );

      targetCustomer.remainingAmount = newRemaining;

      _customersRef.doc(customerIndex).update(targetCustomer.toMap());
      emit(WriteCustomerSuccessState());
    }, "Error deleting payment to customer");
  }

  void addPaymentToCustomer(String customerIndex, double cost) {
    _tryAndCatchBloc(() async {
      if (customerIndex.isEmpty) {
        throw Exception("the id is empty");
      }

      final CustumerModel customer = await _getCustomerbyId(customerIndex);

      final CustumerModel targetCustomer = customer.addPayment(cost);

      targetCustomer.remainingAmount -= cost;

      _customersRef.doc(customerIndex).update(targetCustomer.toMap());
      emit(WriteCustomerSuccessState());
    }, "Error adding payment to customer");
  }

  Future<CustumerModel> _getCustomerbyId(String customerId) async {
    final doc = await _customersRef.doc(customerId).get();

    if (!doc.exists) {
      throw Exception("customer not fount");
    }
    return CustumerModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  }

  void _tryAndCatchBloc(Future<void> Function() func, String msg) async {
    emit(WriteCustomerLoadingState());
    try {
      await func.call();
    } catch (error) {
      emit(WriteCustomerErrorState(msg.toString()));
    }
  }
}
