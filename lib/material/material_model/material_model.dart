class MaterialModel {
  final String name;

  final double amount;
  final double alertAmount;
  final String indexAtDatabase;

  MaterialModel({
    required this.alertAmount,
    required this.name,
    required this.amount,
    required this.indexAtDatabase,
  });

  Map<String, dynamic> toMap() {
    return {"name": name, "amount": amount, "alertAmount": alertAmount};
  }

  factory MaterialModel.fromMap(String docId, Map<String, dynamic> map) {
    return MaterialModel(
      alertAmount: (map["alertAmount"] ?? 0).toDouble(),
      name: map["name"]??" ",
      amount: (map["amount"] ?? 0).toDouble(),
      indexAtDatabase: docId,
    );
  }
}
