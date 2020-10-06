import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Auth extends ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;

  Future<void> signUp(String email, String password) async {
    const API_KEY = 'AIzaSyAKxegToL_LuMfv5UmHNfwpeVJ-eZ_2dII';
    final String url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=$API_KEY';
    final response = await http.post(url,
        body: json.encode(
            {'email': email, 'password': password, 'returnSecureToken': true}));
  }
}
