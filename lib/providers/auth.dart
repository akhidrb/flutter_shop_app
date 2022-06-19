import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {

  Future<void> signUp(String email, String password) async {
    const endpoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAwLd-cmWmXOm--TuZ95Jus2Wh1sPpI1DU';
    final url = Uri.parse(endpoint);
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
  }

  Future<bool> login(String email, String password) async {
    const endpoint =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyAwLd-cmWmXOm--TuZ95Jus2Wh1sPpI1DU';
    final url = Uri.parse(endpoint);
    final response = await http.post(url,
        body: json.encode({
          'email': email,
          'password': password,
          'returnSecureToken': true,
        }));
    return Future.value(response.statusCode == 200);
  }

}
