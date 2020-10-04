import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/models/http_exception.dart';

import 'package:shop_app/providers/product.dart';

class Products with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  List<Product> get items {
    return [..._items];
  }

  List<Product> favItems() {
    return _items.where((element) => element.isfavourite == true).toList();
  }

  Product findById(String id) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future<void> getAndSetPorducts() async {
    final String url =
        'https://flutter-shop-app-651fa.firebaseio.com/products.json';
    try {
      var response = await http.get(url);
      List<Product> loadedProducts = [];
      var extractedData = json.decode(response.body) as Map<String, dynamic>;
      extractedData.forEach((prodId, prodData) {
        loadedProducts.add(Product(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            title: prodData['title'],
            isfavourite: prodData['isfavourite']));
      });
      _items = loadedProducts;
      // print(json.decode(response.body));
    } catch (error) {
      print(error);
    }
  }

  Future<void> addProduct(Product _product) {
    const url = 'https://flutter-shop-app-651fa.firebaseio.com/products.json';

    // this returns the then functions Future
    return http
        .post(url,
            body: json.encode({
              'title': _product.title,
              'description': _product.description,
              'price': _product.price,
              'imageUrl': _product.imageUrl,
              'isfavourite': _product.isfavourite
            }))
        .then((response) {
      print(response.body);
      final newProduct = Product(
          id: json.decode(response.body)['name'],
          description: _product.description,
          imageUrl: _product.imageUrl,
          price: _product.price,
          title: _product.title);
      _items.add(newProduct);
      print("In provider -> ADD");
      notifyListeners();
    }).catchError((error) {
      print(error);
      // We will be able to catch this thrown error in the editScreen
      throw error;
    });
  }

  Future<void> updateProduct(Product _product) async {
    final url =
        'https://flutter-shop-app-651fa.firebaseio.com/products/${_product.id}.json';
    print("In provider -> UPDATE");
    final replacementIndex =
        _items.indexWhere((element) => element.id == _product.id);

    await http.patch(url,
        body: json.encode({
          'title': _product.title,
          'description': _product.description,
          'imageUrl': _product.imageUrl,
          '_price': _product.price
        }));
    _items[replacementIndex] = _product;

    notifyListeners();
  }

  Future<void> deleteProduct(String _selectedId) {
    final url =
        'https://flutter-shop-app-651fa.firebaseio.com/products/$_selectedId.json';
    final elementIndex =
        _items.indexWhere((element) => element.id == _selectedId);
    var existingProduct = _items[elementIndex];
    _items.removeWhere((element) => element.id == _selectedId);
    notifyListeners();
    print("DELETED");
    return http.delete(url).then((response) {
      if (response.statusCode >= 400) {
        throw HttpException('Could not delete the product.');
      }
    }).then((value) {
      print("INSIDE THEN");
      _items.removeWhere((element) => element.id == _selectedId);
      notifyListeners();
    }).catchError((error) {
      print("RE-INSERTED");

      _items.insert(elementIndex, existingProduct);
      notifyListeners();
      throw HttpException('Could not delete the product.');
    });
  }
}
