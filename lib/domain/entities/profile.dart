class Income {
  final double amount;
  final DateTime date;

  Income({required this.amount, required this.date});

  Map<String, dynamic> toJson() => {
    'amount': amount,
    'date': date.toIso8601String(),
  };

  factory Income.fromJson(Map<String, dynamic> json) =>
      Income(amount: json['amount'], date: DateTime.parse(json['date']));
}
