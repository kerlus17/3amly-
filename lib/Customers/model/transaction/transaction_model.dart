import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionModel {
  final String nameOrder;
  final double cost;
  final double payed;
  final double rest;

  final DateTime date;

  TransactionModel({
    required this.nameOrder,
    required this.cost,
    required this.date,
    required this.payed,
    required this.rest,
  });

  Map<String, dynamic> toMap() {
    return {
      "nameOrder": nameOrder,
      "cost": cost,
      "payed": payed,
      "rest": rest,
      "date": Timestamp.fromDate(date),
    };
  }

  factory TransactionModel.fromMap(Map<String, dynamic> map) {
    return TransactionModel(
      nameOrder: map["nameOrder"],
      cost: (map["cost"] ?? 0).toDouble(),
      date: map['date'] is Timestamp
          ? (map['date'] as Timestamp).toDate()
          : DateTime.now(),
      payed: (map["payed"] ?? 0).toDouble(),
      rest: (map["rest"] ?? 0).toDouble(),
    );
  }
}
