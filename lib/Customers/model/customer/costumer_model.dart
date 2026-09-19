import 'package:elwaqar/Customers/model/payment/payment_model.dart';
import 'package:elwaqar/Customers/model/transaction/transaction_model.dart';
import 'package:flutter/foundation.dart';

class CustumerModel {
  final String name;
  final int color;

  final String description;
  String indexAtDatabase;
  double remainingAmount;
  bool debtOrNo;
  List<PaymentModel> paymentsHistory;

  List<TransactionModel> transactionsHistory;

  CustumerModel({
    required this.name,
    required this.description,
    required this.remainingAmount,
    required this.debtOrNo,
    required this.color,
    required this.indexAtDatabase,
    this.paymentsHistory = const [],
    this.transactionsHistory = const [],
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "color": color,
      "description": description,
      "indexAtDatabase": indexAtDatabase,
      "remainingAmount": remainingAmount,
      "debtOrNo": debtOrNo,
      "paymentsHistory": paymentsHistory.map((e) => e.toMap()).toList(),
      "transactionsHistory": transactionsHistory.map((e) => e.toMap()).toList(),
    };
  }

  factory CustumerModel.fromMap(String docId, Map<String, dynamic> map) {
    return CustumerModel(
      indexAtDatabase: docId,
      name: map['name'] ?? '',
      color: map['color'] ?? 0xFFD4537E,
      description: map['description'] ?? '',
      remainingAmount: (map['remainingAmount'] ?? 0).toDouble(),
      debtOrNo: map['debtOrNo'] ?? false,
      paymentsHistory: ((map['paymentsHistory'] as List?) ?? [])
          .map((e) => PaymentModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      transactionsHistory: ((map["transactionsHistory"] as List?) ?? [])
          .map((e) => TransactionModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }

  CustumerModel addTransaction(
    String nameofOrder,
    double cost,
    double payed,
    double rest,
  ) {
    List<TransactionModel> transactions = List.from(transactionsHistory);

    transactions.add(
      TransactionModel(
        nameOrder: nameofOrder,
        cost: cost,
        date: DateTime.now(),
        payed: payed,
        rest: rest,
      ),
    );

    return CustumerModel(
      debtOrNo: debtOrNo,
      name: name,
      description: description,
      remainingAmount: remainingAmount,
      color: color,
      indexAtDatabase: indexAtDatabase,
      paymentsHistory: paymentsHistory,
      transactionsHistory: transactions,
    );
  }

  CustumerModel editTransaction(
    int indexOfTransaction,
    String nameofOrder,
    double cost,
    double payed,
    double rest,
    DateTime Date,
  ) {
    List<TransactionModel> transactions = List.from(transactionsHistory);

    transactions[indexOfTransaction] = TransactionModel(
      cost: cost,
      date: Date,
      nameOrder: nameofOrder,
      payed: payed,
      rest: rest,
    );

    return CustumerModel(
      debtOrNo: debtOrNo,
      name: name,
      description: description,
      remainingAmount: remainingAmount,
      color: color,
      indexAtDatabase: indexAtDatabase,
      paymentsHistory: paymentsHistory,
      transactionsHistory: transactions,
    );
  }

  CustumerModel editPayment(int indexOfpayment, double amount, DateTime date) {
    List<PaymentModel> payments = List.from(paymentsHistory);

    payments[indexOfpayment] = PaymentModel(
      amount: amount,
      date: date,
    );

    return CustumerModel(
      debtOrNo: debtOrNo,
      name: name,
      description: description,
      remainingAmount: remainingAmount,
      color: color,
      indexAtDatabase: indexAtDatabase,
      paymentsHistory: payments,
      transactionsHistory: transactionsHistory,
    );
  }

  CustumerModel addPayment(double amount) {
    List<PaymentModel> pays = List.from(paymentsHistory);

    pays.add(
      PaymentModel(amount: amount, date: DateTime.now(),),
    );

    return CustumerModel(
      debtOrNo: debtOrNo,
      name: name,
      description: description,
      remainingAmount: remainingAmount,
      color: color,
      indexAtDatabase: indexAtDatabase,
      paymentsHistory: pays,
      transactionsHistory: transactionsHistory,
    );
  }

  CustumerModel deleteTransaction(int indexOfTransaction) {
    List<TransactionModel> transactions = List.from(transactionsHistory);

    transactions.removeAt(indexOfTransaction);

    return CustumerModel(
      debtOrNo: debtOrNo,
      name: name,
      description: description,
      remainingAmount: remainingAmount,
      color: color,
      indexAtDatabase: indexAtDatabase,
      paymentsHistory: paymentsHistory,
      transactionsHistory: transactions,
    );
  }

  CustumerModel deletePayment(int indexOfPayment) {
    List<PaymentModel> pays = List.from(paymentsHistory);

    pays.removeAt(indexOfPayment);

    return CustumerModel(
      debtOrNo: debtOrNo,
      name: name,
      description: description,
      remainingAmount: remainingAmount,
      color: color,
      indexAtDatabase: indexAtDatabase,
      paymentsHistory: pays,
      transactionsHistory: transactionsHistory,
    );
  }
}
