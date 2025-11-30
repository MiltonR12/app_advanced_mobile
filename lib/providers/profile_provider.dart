import 'dart:convert';

import 'package:app_advanced_mobile/domain/entities/profile.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider extends ChangeNotifier {
  String name = "Usuario";
  String? photoUrl;

  double _balance = 0;
  double get balance => _balance;

  final List<Income> _incomes = [];
  List<Income> get incomes => List.unmodifiable(_incomes);

  ProfileProvider() {
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final prefs = await SharedPreferences.getInstance();

    name = prefs.getString('profile_name') ?? "Usuario";
    photoUrl = prefs.getString('profile_photo');
    _balance = prefs.getDouble('profile_balance') ?? 0.0;

    final incomesData = prefs.getString('profile_incomes');
    if (incomesData != null) {
      final List decoded = jsonDecode(incomesData);
      _incomes.clear();
      _incomes.addAll(decoded.map((e) => Income.fromJson(e)));
    }

    notifyListeners();
  }

  Future<void> _saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('profile_name', name);
    if (photoUrl != null) await prefs.setString('profile_photo', photoUrl!);
    await prefs.setDouble('profile_balance', _balance);

    final incomesData = jsonEncode(_incomes.map((i) => i.toJson()).toList());
    await prefs.setString('profile_incomes', incomesData);
  }

  void updateName(String newName) {
    name = newName;
    _saveProfile();
    notifyListeners();
  }

  void updatePhoto(String url) {
    photoUrl = url;
    _saveProfile();
    notifyListeners();
  }

  void addIncome(double amount) {
    _incomes.add(Income(amount: amount, date: DateTime.now()));
    _balance += amount;
    _saveProfile();
    notifyListeners();
  }

  void reduceBalance(double amount) {
    _balance -= amount;
    _saveProfile();
    notifyListeners();
  }
}
