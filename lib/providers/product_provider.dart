import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [
    Product(
      id: '1',
      name: 'Sandia',
      price: 999.99,
      quantity: 10,
      category: ProductCategory.frutas,
      imageUrl: null,
    ),
    Product(
      id: '2',
      name: 'Carne',
      price: 49.99,
      quantity: 25,
      category: ProductCategory.carnes,
      imageUrl: null,
    ),
    Product(
      id: '3',
      name: 'Manzanas',
      price: 2.99,
      quantity: 100,
      category: ProductCategory.frutas,
      isFavorite: true,
      imageUrl: null,
    ),
    Product(
      id: '4',
      name: 'Leche',
      price: 3.49,
      quantity: 50,
      isFavorite: true,
      category: ProductCategory.lacteos,
      imageUrl: null,
    ),
    Product(
      id: '5',
      name: 'Tomate',
      price: 1.99,
      quantity: 80,
      category: ProductCategory.verduras,
      imageUrl: null,
    ),
  ];

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get favoriteProducts =>
      _products.where((product) => product.isFavorite).toList();

  void addProduct(Product product) {
    Product? existingProduct = isProductNameExists(product.name);
    if (existingProduct == null) {
      _products.add(product);
      notifyListeners();
    } else {
      addQuantity(existingProduct.id, product.quantity);
    }
  }

  Product? isProductNameExists(String name) {
    return _products.firstWhereOrNull((product) => product.name == name);
  }

  void removeProduct(String id) {
    _products.removeWhere((product) => product.id == id);
    notifyListeners();
  }

  void addQuantity(String id, int quantity) {
    final product = _products.firstWhere((product) => product.id == id);
    product.quantity += quantity;
    notifyListeners();
  }

  void updateProduct(String id, {int? quantity, double? price}) {
    final product = _products.firstWhereOrNull((product) => product.id == id);
    if (product == null) return;

    if (quantity != null) product.quantity = quantity;
    if (price != null) product.price = price;

    notifyListeners();
  }

  void toggleFavoriteStatus(String id) {
    final product = _products.firstWhere((product) => product.id == id);
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
