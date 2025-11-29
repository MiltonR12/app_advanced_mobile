import 'package:app_advanced_mobile/domain/entities/purchase.dart';
import 'package:flutter/material.dart';

class PurchaseProvider extends ChangeNotifier {
  final List<Purchase> _purchases = [];

  List<Purchase> get purchases => _purchases;

  void addPurchase(Purchase purchase) {
    _purchases.add(purchase);
    notifyListeners();
  }

  double get totalAmount =>
      _purchases.fold(0.0, (sum, item) => sum + item.amount);
}
