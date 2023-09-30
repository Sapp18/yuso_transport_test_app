import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../app/app.dart';

class AppService {
  final Map<String, String> _header = {
    "Content-type": "application/json",
    'Accept': 'application/json',
  };

  Future<Response> apiPost(String path, Map<String, dynamic> body,
      {String? token}) async {
    Response request = Response('Error', 500);
    try {
      request = await http.post(
        Uri.https('${AppConstants.apiUrl}:8443', '/api/$path/'),
        headers: token!.isEmpty
            ? _header
            : {
                'Accept': 'application/json',
                'Content-type': 'application/json',
                'Authorization': "Bearer $token"
              },
        body: jsonEncode(body),
      );
    } catch (e) {
      log("error in apiPost: $e");
    }
    return request;
  }

  Future<Response> apiGet(String path, {token}) async {
    Response request = Response('Error', 500);
    try {
      request = await http.get(
        Uri.https('${AppConstants.apiUrl}:8443', '/api/$path/'),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );
    } catch (e) {
      log("error in apiGet: $e");
    }
    return request;
  }

  Future<Response> apiDelete(String path, {token, key}) async {
    Response request = Response('Error', 500);
    try {
      request = await http.delete(
        Uri.https('${AppConstants.apiUrl}:8443', '/api/$path/$key'),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
      );
    } catch (e) {
      log("error in apiGet: $e");
    }
    return request;
  }

  Future<Response> apiPut(String path, Map<String, dynamic> body,
      {token, key}) async {
    Response request = Response('Error', 500);
    try {
      request = await http.put(
        Uri.https('${AppConstants.apiUrl}:8443', '/api/$path/$key'),
        headers: {
          'Accept': 'application/json',
          'Content-type': 'application/json',
          'Authorization': "Bearer $token"
        },
        body: jsonEncode(body),
      );
    } catch (e) {
      log("error in apiGet: $e");
    }
    return request;
  }
}
