import 'package:flutter/material.dart';

class CartItem with ChangeNotifier {
  final int id;
  final String title;
  final String imageUrl;
  final double price;
  final int quantity;

  CartItem({
    @required this.id,
    @required this.quantity,
    @required this.imageUrl,
    @required this.price,
    @required this.title,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};
  int cartID = 0;

  Map<String, CartItem> get items {
    return {..._items};
  }

  int getCartItemsCount() {
    return _items.length;
  }

  double total() {
    double total = 0;

    _items.forEach((key, value) {
      total += value.price * value.quantity;
    });
    return total;
  }

  void deleteItem(String productId) {
    print('In delete Item method $productId');
    _items.remove(productId);
    notifyListeners();
  }

  void addItem(String pid, double price, String title, String imageUrl) {
    if (_items.containsKey(pid)) {
      _items.update(
          pid,
          (existingItem) => CartItem(
              imageUrl: existingItem.imageUrl,
              id: existingItem.id,
              quantity: existingItem.quantity + 1,
              price: existingItem.price,
              title: existingItem.title));
    } else {
      _items.putIfAbsent(
          pid,
          () => CartItem(
              imageUrl: imageUrl,
              id: ++cartID,
              quantity: 1,
              price: price,
              title: title));
    }
    notifyListeners();
  }
}
