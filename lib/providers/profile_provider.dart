import 'package:app_advanced_mobile/domain/entities/profile.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String name = "Usuario";
  String? photoUrl;

  double _balance = 0;
  double get balance => _balance;

  final List<Income> _incomes = [];
  List<Income> get incomes => _incomes;

  // ACTUALIZAR NOMBRE
  void updateName(String newName) {
    name = newName;
    notifyListeners();
  }

  // ACTUALIZAR FOTO
  void updatePhoto(String url) {
    photoUrl = url;
    notifyListeners();
  }

  // AGREGAR INGRESO
  void addIncome(double amount) {
    _incomes.add(Income(amount: amount, date: DateTime.now()));
    _balance += amount;
    notifyListeners();
  }

  void reduceBalance(double amount) {
    _balance -= amount;
    notifyListeners();
  }
}
