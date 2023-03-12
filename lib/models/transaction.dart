class Transaction {
  final String name;

  final String category;

  final double amount;

  final bool isExpense;

  final DateTime createdAt;

  Transaction(
      {required this.name,
      required this.category,
      required this.amount,
      required this.isExpense,
      required this.createdAt});

  Transaction.fromJson(Map<String, dynamic> json)
      : this(
          name: json["name"] as String,
          category: json["category"] as String,
          amount: json["amount"] as double,
          isExpense: json["isExpense"] as bool,
          createdAt: json["createdAt"] as DateTime,
        );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "category": category,
      "amount": amount,
      "isExpense": isExpense,
      "createdAt": createdAt
    };
  }
}
