import 'package:app_advanced_mobile/domain/entities/purchase.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PurchaseProvider extends ChangeNotifier {
  final List<Purchase> _purchases = List.generate(15, (index) {
    final amount = 10 + (index * 12.5);
    return Purchase(
      item: Purchase.mockProduct(index), // Creamos un método mock en Product
      amount: amount,
    );
  });

  List<Purchase> get purchases => List.unmodifiable(_purchases);

  void addPurchase(Purchase purchase) {
    _purchases.add(purchase);
    notifyListeners();
  }

  double get totalAmount =>
      _purchases.fold(0.0, (sum, item) => sum + item.amount);
}
