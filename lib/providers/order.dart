import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:shop_app/providers/cart.dart';

class OrderItem with ChangeNotifier {
  final String id;
  final double amount;
  final List<CartItem> items;
  final DateTime created;
  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.items,
      @required this.created});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];
  int orderId = 0;
  List<OrderItem> get orders {
    print(_orders);
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartItems, double amount) async {
    if (amount <= 0) {
      return;
    }
    final datetime = DateTime.now();
    const url = 'https://flutter-shop-app-651fa.firebaseio.com/orders.json';
    print(cartItems);

    final response = await http.post(url,
        body: json.encode({
          'amount': amount,
          'created': datetime.toIso8601String(),
          'items': cartItems.map((item) {
            return json.encode({
              'id': item.id,
              'title': item.title,
              'imageUrl': item.imageUrl,
              'price': item.price,
              'quantity': item.quantity
            });
          }).toList()
        }));
    // print(response.body);
    _orders.add(OrderItem(
        amount: amount,
        created: datetime,
        id: json.decode(response.body)['name'],
        items: cartItems));
    notifyListeners();
  }

  Future<void> getAndSetOrders() async {
    const url = 'https://flutter-shop-app-651fa.firebaseio.com/orders.json';
    final response = await http.get(url);
    // print(json.decode(response.body));
    print("RELOADED ORDERS");
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    List<OrderItem> loadedOrders = [];
    if (extractedData != null) {
      extractedData.forEach((orderId, orderData) {
        loadedOrders.add(OrderItem(
            id: orderId,
            amount: orderData['amount'],
            items: (orderData['items'] as List<dynamic>).map((item) {
              // item = json.decode(item) ;
              // print(json.decode(item)['imageUrl']);
              // print(item['id']);
              CartItem(
                  id: json.decode(item)['id'],
                  quantity: json.decode(item)['quantity'],
                  imageUrl: json.decode(item)['imageUrl'],
                  price: json.decode(item)['price'],
                  title: json.decode(item)['title']);
            }).toList(),
            created: DateTime.parse(orderData['created'])));
      });
    } else {
      _orders = [];
      notifyListeners();
    }
  }
}
