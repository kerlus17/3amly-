import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elwaqar/Customers/controller/customer_read_data_cubit/read_customer_states.dart';
import 'package:elwaqar/Customers/model/customer/costumer_model.dart';
import 'package:elwaqar/Customers/model/payment/payment_model.dart';
import 'package:elwaqar/Customers/model/transaction/transaction_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

class ReadCustomerCubit extends Cubit<ReadCustomerState> {
  ReadCustomerCubit() : super(ReadCustomerInitialState());
  static ReadCustomerCubit get(context) => BlocProvider.of(context);

  final CollectionReference _customersRef = FirebaseFirestore.instance
      .collection("customers");

  TransactionsORpayments TransactionOrPayment =
      TransactionsORpayments.transactions;

  StreamSubscription? _subscription;

  List<CustumerModel> _cachedCustomers = [];

  void updateTransactionOrPayment(TransactionsORpayments) {
    this.TransactionOrPayment = TransactionsORpayments;
    getCustomers();
  }

  void getCustomers() {
    emit(ReadCustomerLoadingState());

    _subscription?.cancel();

    _subscription = _customersRef.snapshots().listen(
      (snapshot) {
        _cachedCustomers = snapshot.docs
            .map(
              (e) =>
                  CustumerModel.fromMap(e.id, e.data() as Map<String, dynamic>),
            )
            .toList();
        emit(ReadCustomerSuccessState(_cachedCustomers));
      },
      onError: (e) {
        emit(
          ReadCustomerErrorState(
            "error when getting customers ${e.toString()}",
          ),
        );
      },
    );
  }

  List<TransactionModel> getTransaction(CustumerModel customer) {
    try {
      final target = _cachedCustomers.firstWhere(
        (e) => e.indexAtDatabase == customer.indexAtDatabase,
        orElse: () => customer,
      );
      return target.transactionsHistory;
    } catch (e) {
      return [];
    }
  }

  double totalOutRemining() {
    try {
      double total = 0;
      for (var customer in _cachedCustomers) {
        List<TransactionModel> tran = customer.transactionsHistory;
        for (var element in tran) {
          total += element.rest;
        }
        List<PaymentModel> pays = customer.paymentsHistory;
        for (var pay in pays) {
          total -= pay.amount;
        }
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  double Totalpurchases(String customerId) {
    try {
      final customer = _cachedCustomers.firstWhere(
        (c) => c.indexAtDatabase == customerId,
      );
      double total = 0;
      for (var tran in customer.transactionsHistory) {
        total += tran.cost;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  double TotalpurchasesUntillNow() {
    try {
      double total = 0;
      for (CustumerModel customer in _cachedCustomers) {
        for (var tran in customer.transactionsHistory) {
          DateTime oldDate = DateTime(2026, 1, 15);
          final diff = oldDate.difference(tran.date);
          if (diff.inDays <= 365) {
            total += tran.cost;
          }
        }
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  double TotalWinsWithRemains() {
    try {
      double total = 0;
      for (CustumerModel customer in _cachedCustomers) {
        for (var tran in customer.transactionsHistory) {
          DateTime oldDate = DateTime(2026, 1, 15);
          final diff = oldDate.difference(tran.date);
          if (diff.inDays <= 365) {
            total += tran.cost;
          }
        }
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  int totalDeptCustomers() {
    try {
      int total = 0;
      for (var customer in _cachedCustomers) {
        if (customer.debtOrNo) total += 1;
      }
      return total;
    } catch (e) {
      return 0;
    }
  }

  String bestCustomer() {
    try {
      String best = "";
      double thebestNum = 0;
      for (var customer in _cachedCustomers) {
        double total = 0;
        for (var tran in customer.transactionsHistory) {
          total += tran.cost;
        }
        if (total > thebestNum) {
          best = customer.name;
          thebestNum = total;
        }
      }
      return best;
    } catch (e) {
      return "";
    }
  }

  double Totalremaining(String customerId) {
    try {
      final customer = _cachedCustomers.firstWhere(
        (c) => c.indexAtDatabase == customerId,
      );
      double total = 0;
      for (var tran in customer.transactionsHistory) {
        total += tran.rest;
      }
      for (var pay in customer.paymentsHistory) {
        total -= pay.amount;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }


  
  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }

  double Totalpayed(String customerId) {
    try {
      final customer = _cachedCustomers.firstWhere(
        (c) => c.indexAtDatabase == customerId,
      );
      double total = 0;
      for (var tran in customer.transactionsHistory) {
        total += tran.payed;
      }
      for (var pay in customer.paymentsHistory) {
        total += pay.amount;
      }
      return total;
    } catch (e) {
      return 0.0;
    }
  }

  int numberOfCustomer() {
    return _cachedCustomers.length;
  }
}

enum TransactionsORpayments { transactions, payments }
