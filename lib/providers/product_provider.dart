import 'dart:convert';

import 'package:app_advanced_mobile/domain/entities/product.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products = [];
  List<Product> _favorites = [];
  List<Product> get products => List.unmodifiable(_products);

  List<Product> get favoriteProducts => List.unmodifiable(_favorites);

  bool get isExistFavorite => _favorites.any((product) => product.isFavorite);

  bool get isExistSelected => _products.any((product) => product.isSelected);

  ProductProvider() {
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('products');

    if (data != null) {
      final List decoded = jsonDecode(data);
      _products = decoded.map((e) => Product.fromJson(e)).toList();
    } else {
      _products = [];
      await _saveProducts();
    }
    notifyListeners();
  }

  Future<void> _saveProducts() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_products.map((p) => p.toJson()).toList());
    await prefs.setString('products', data);
  }

  void addProduct(Product product) {
    final existingProduct = isProductNameExists(product.name);
    if (existingProduct == null) {
      _products.add(product);
      _saveProducts();
      notifyListeners();
    }
  }

  void updateProduct(String id, {double? price}) {
    final product = _products.firstWhereOrNull((p) => p.id == id);
    if (product != null) {
      if (price != null) product.price = price;
      _saveProducts();
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    _products.removeWhere((p) => p.id == id);
    _saveProducts();
    notifyListeners();
  }

  void toggleSelectionStatus(String id, bool isSelected) {
    final product = _products.firstWhere((p) => p.id == id);
    product.isSelected = isSelected;
    _saveProducts();
    notifyListeners();
  }

  void clearSelection() {
    _products.removeWhere((product) => product.isSelected);
    _saveProducts();
    notifyListeners();
  }

  void toggleFavoriteStatus(String name) {
    final product = _products.firstWhere(
      (p) => p.name.toLowerCase() == name.toLowerCase(),
    );
    product.isFavorite = !product.isFavorite;

    if (product.isFavorite) {
      _favorites.add(product);
    } else {
      _favorites.removeWhere((p) => p.name.toLowerCase() == name.toLowerCase());
    }

    _saveProducts();
    notifyListeners();
  }

  Product? isProductNameExists(String name) {
    return _products.firstWhereOrNull(
      (product) => product.name.toLowerCase() == name.toLowerCase(),
    );
  }
}
