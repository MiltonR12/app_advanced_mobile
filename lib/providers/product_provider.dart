import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

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

  void updateProduct(String id, {int? quantity, String? imageUrl}) {
    Product? product = isProductNameExists(id);
    if (product == null) return;
    if (quantity != null) product.quantity = quantity;
    if (imageUrl != null) product.imageUrl = imageUrl;

    notifyListeners();
  }

  void toggleFavoriteStatus(String id) {
    final product = _products.firstWhere((product) => product.id == id);
    product.isFavorite = !product.isFavorite;
    notifyListeners();
  }
}
