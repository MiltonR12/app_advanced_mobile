enum ProductCategory { frutas, verduras, carnes, lacteos, bebidas }

class Product {
  String id;
  String name;
  double price;
  ProductCategory category;
  bool isFavorite;
  bool isSelected = false;
  String? imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.category,
    this.isFavorite = false,
    this.isSelected = false,
    this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json['id'],
    name: json['name'],
    price: json['price'],
    category: ProductCategory.values[json['category']],
    isFavorite: json['isFavorite'] ?? false,
    isSelected: json['isSelected'] ?? false,
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'price': price,
    'category': category.index,
    'isFavorite': isFavorite,
    'isSelected': isSelected,
    'imageUrl': imageUrl,
  };
}
