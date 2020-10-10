import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  final String userId;
  bool isfavourite;

  void toggleFavs(_authToken, _userId) async {
    final url =
        'https://flutter-shop-app-651fa.firebaseio.com/userFavourites/$_userId/$id.json?auth=$_authToken';
    final response =
        await http.put(url, body: json.encode({'isfavourite': !isfavourite}));
    isfavourite = !isfavourite;
    notifyListeners();
  }

  Product(
      {@required this.id,
      @required this.title,
      @required this.description,
      @required this.price,
      @required this.imageUrl,
      this.isfavourite = false,
      this.userId});
}
