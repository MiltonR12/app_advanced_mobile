import 'dart:convert';

import 'package:app_advanced_mobile/domain/entities/purchase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PurchaseProvider extends ChangeNotifier {
  final List<Purchase> _purchases = [];

  List<Purchase> get purchases => List.unmodifiable(_purchases);

  PurchaseProvider() {
    _loadPurchases();
  }

  Future<void> _loadPurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getString('purchases');

    if (data != null) {
      final List decoded = jsonDecode(data);
      _purchases.clear();
      _purchases.addAll(decoded.map((e) => Purchase.fromJson(e)));
    }

    notifyListeners();
  }

  Future<void> _savePurchases() async {
    final prefs = await SharedPreferences.getInstance();
    final data = jsonEncode(_purchases.map((p) => p.toJson()).toList());
    await prefs.setString('purchases', data);
  }

  void addPurchase(Purchase purchase) {
    _purchases.add(purchase);
    _savePurchases();
    notifyListeners();
  }

  double get totalAmount =>
      _purchases.fold(0.0, (sum, item) => sum + item.amount);

  void clearPurchases() {
    _purchases.clear();
    _savePurchases();
    notifyListeners();
  }
}
