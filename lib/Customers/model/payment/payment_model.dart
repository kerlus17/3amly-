import 'package:cloud_firestore/cloud_firestore.dart';

class PaymentModel {
  final double amount;
  final DateTime date;
  PaymentModel({required this.amount, required this.date});

  Map<String, dynamic> toMap() {
    return {"amount": amount, "date": Timestamp.fromDate(date)};
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel(
      amount: (map["amount"] ?? 0).toDouble(),
      date: map["date"] is Timestamp
          ? (map["date"] as Timestamp).toDate()
          : DateTime.now(),
    );
  }
}
