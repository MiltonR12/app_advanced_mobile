import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeProvider extends ChangeNotifier {
  AppTheme _theme = AppTheme.light;

  AppTheme get theme => _theme;

  void toggleTheme() {
    _theme = _theme == AppTheme.light ? AppTheme.dark : AppTheme.light;
    print('Theme changed to: $_theme');
    notifyListeners();
  }
}
