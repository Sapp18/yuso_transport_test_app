import 'package:flutter/material.dart';

class SignInProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool hiddenPassword = true;
  final data = {
    "userName": "",
    "password": "",
  };

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  showPassword() {
    hiddenPassword = !hiddenPassword;
    notifyListeners();
  }
}
