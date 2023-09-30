import 'dart:typed_data';

import 'package:flutter/material.dart';

import '../../../domain/models/auth/list_customer_model.dart';

class NewPersonProvider extends ChangeNotifier {
  NewPersonProvider({List<Value>? value}) {
    if (value!.isEmpty) {
    } else {
      key = value[0].oid ?? '';
      data = {
        "Photo": value[0].photo,
        "FirstName": value[0].firstName,
        "LastName": value[0].lastName,
        "MiddleName": value[0].middleName,
        "Email": value[0].email,
        "Phone": value[0].phone
      };
    }
    notifyListeners();
  }
  bool _isLoading = false;
  Uint8List? _photo;
  String key = '';
  Map<String, dynamic> data = {
    "Photo": null,
    "FirstName": "",
    "LastName": "",
    "MiddleName": "",
    "Email": "",
    "Phone": ""
  };

  Uint8List? get photo => _photo;
  set photo(Uint8List? value) {
    _photo = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
