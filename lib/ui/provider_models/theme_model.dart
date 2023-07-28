import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _ourThemeMode = ThemeMode.light;
  bool _light = true;
  IconData _iconData = _iconDark;
  static const _iconLight = Icons.light_mode_outlined;
  static const _iconDark = Icons.dark_mode_rounded;

  get getOurThemeMode => _ourThemeMode;
  get getSwitchState => _light;
  get getIcon => _iconData;

  void switchThemeMode() {
    _light = !_light;
    _ourThemeMode = _light ? ThemeMode.light : ThemeMode.dark;
    _iconData = _light ? _iconDark : _iconLight;
    notifyListeners();
  }
}
