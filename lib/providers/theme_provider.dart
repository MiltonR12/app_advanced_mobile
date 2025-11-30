import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';

enum AppTheme { light, dark }

class ThemeProvider extends ChangeNotifier {
  AppTheme _theme = AppTheme.light;

  AppTheme get theme => _theme;

  void toggleTheme(BuildContext context) {
    if (_theme == AppTheme.light) {
      AdaptiveTheme.of(context).setDark();
      _theme = AppTheme.dark;
    } else {
      AdaptiveTheme.of(context).setLight();
      _theme = AppTheme.light;
    }
    notifyListeners();
    print('Theme changed to: $_theme');
  }
}
