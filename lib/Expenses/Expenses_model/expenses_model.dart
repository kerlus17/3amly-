import 'package:cloud_firestore/cloud_firestore.dart';

class ExpenseModel {
  final String name;
  final DateTime date;
  final double price;
  final String indexAtDatabase;

  ExpenseModel({
    required this.name,
    required this.date,
    required this.price,
    required this.indexAtDatabase,
  });

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "price": price,
      "indexAtDatabase": indexAtDatabase,
      "date": Timestamp.fromDate(date),
    };
  }

  factory ExpenseModel.fromMap(String docId, Map<String, dynamic> map) {
    return ExpenseModel(
      name: map["name"]?? " ",
      date: map["date"] is Timestamp
          ? (map["date"] as Timestamp).toDate()
          : DateTime.now(),
      price: (map["price"]?? 0).toDouble(),
      indexAtDatabase: docId,
    );
  }
}
