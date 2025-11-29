import 'package:app_advanced_mobile/domain/entities/product.dart';

class Purchase {
  final Product item;
  final DateTime date = DateTime.now();
  final double amount;

  Purchase({required this.item, required this.amount});

  static Product mockProduct(int index) {
    final categories = ProductCategory.values;
    return Product(
      id: 'mock_$index',
      name: 'Producto $index',
      price: 10.0 + index,
      quantity: 1 + index,
      category: categories[index % categories.length],
      imageUrl: null,
    );
  }
}
