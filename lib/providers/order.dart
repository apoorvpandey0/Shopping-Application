import 'package:flutter/material.dart';
import 'package:shop_app/providers/cart.dart';

class OrderItem with ChangeNotifier {
  final int id;
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
  final List<OrderItem> _orders = [];
  int orderId = 0;
  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> cartItems, double amount) {
    _orders.add(OrderItem(
        amount: amount,
        created: DateTime.now(),
        id: ++orderId,
        items: cartItems));
  }

  notifyListeners();
}
