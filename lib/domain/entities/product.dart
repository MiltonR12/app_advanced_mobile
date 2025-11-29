enum ProductCategory { frutas, verduras, carnes, lacteos, bebidas }

class Product {
  final String id;
  final String name;
  double price;
  String? imageUrl;
  final ProductCategory category;
  bool isFavorite;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    this.isFavorite = false,
    this.quantity = 0,
  });
}
