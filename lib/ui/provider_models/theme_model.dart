import 'package:flutter/material.dart';

class ThemeModel extends ChangeNotifier {
  ThemeMode _ourThemeMode = ThemeMode.light;
  bool _switchState = false;
  IconData _iconData = _iconLight;
  static const _iconLight = Icons.light_mode_outlined;
  static const _iconDark = Icons.dark_mode;

  get getOurThemeMode => _ourThemeMode;
  get getSwitchState => _switchState;
  get getIcon => _iconData;

  void switchThemeMode() {
    _switchState = !_switchState;
    _ourThemeMode = _switchState ? ThemeMode.dark : ThemeMode.light;
    _iconData = _switchState ? _iconDark : _iconLight;
    notifyListeners();
  }
}
