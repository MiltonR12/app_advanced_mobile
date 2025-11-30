import 'product.dart';

class Purchase {
  final Product item;
  final DateTime date;
  final double amount;

  Purchase({required this.item, required this.amount, DateTime? date})
    : date = date ?? DateTime.now();

  // Serialización a JSON
  Map<String, dynamic> toJson() => {
    'item': item.toJson(),
    'amount': amount,
    'date': date.toIso8601String(),
  };

  factory Purchase.fromJson(Map<String, dynamic> json) => Purchase(
    item: Product.fromJson(json['item']),
    amount: json['amount'],
    date: DateTime.parse(json['date']),
  );

  // Producto de prueba
  static Product mockProduct(int index) {
    final categories = ProductCategory.values;
    return Product(
      id: 'mock_$index',
      name: 'Producto $index',
      price: 10.0 + index,
      category: categories[index % categories.length],
      imageUrl: null,
    );
  }
}
