import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:yuso_transport_test_app/domain/models/auth/list_customer_model.dart';
import 'package:yuso_transport_test_app/domain/services/app_service.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({String? token}) {
    getInfo(token!);
    apiToken = token;
  }
  String apiToken = '';
  ListCustomerModel? listCustomerModel;

  void getInfo(String token) async {
    final value = await AppService().apiGet('odata/Customer', token: token);
    if (value.statusCode == 200) {
      listCustomerModel = listCustomerModelFromJson(value.body);
    } else {
      log('Error statusCode:${value.statusCode}');
    }
    notifyListeners();
  }
}
