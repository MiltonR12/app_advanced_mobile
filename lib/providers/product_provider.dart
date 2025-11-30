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
  final List<Product> _favoriteProducts = [];

  List<Product> get products => List.unmodifiable(_products);

  List<Product> get favoriteProducts => _favoriteProducts;

  bool get isExistFavorite => _favoriteProducts.isNotEmpty;

  bool get isExistSelected => _products.any((product) => product.isSelected);

  void addProduct(Product product) {
    Product? existingProduct = isProductNameExists(product.name);
    if (existingProduct == null) {
      _products.add(product);
      notifyListeners();
    } else {
      addQuantity(existingProduct.id, product.quantity);
    }
  }

  void toggleSelectionStatus(String id, bool isSelected) {
    final product = _products.firstWhere((product) => product.id == id);
    product.isSelected = isSelected;
    notifyListeners();
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

    if (product.isFavorite) {
      _favoriteProducts.add(product);
    } else {
      _favoriteProducts.removeWhere((favProduct) => favProduct.id == id);
    }

    notifyListeners();
  }

  void clearSelection() {
    _products.removeWhere((product) => product.isSelected);
    notifyListeners();
  }
}
