import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatefulWidget {
  static const routeName = '/cart-screen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  bool _isLoading = false;
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(title: Text("My Cart")),
        body: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Column(children: <Widget>[
                Card(
                  margin: EdgeInsets.all(10),
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        Spacer(),
                        Chip(
                          label: Text(
                            '\$ ${cartData.total.round()}',
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.purple,
                        ),
                        FlatButton(
                            onPressed: () {
                              setState(() {
                                _isLoading = true;
                              });
                              Provider.of<Orders>(context, listen: false)
                                  .addOrder(
                                      // items.values returns an iterable which we then convert to a list
                                      cartData.items.values.toList(),
                                      cartData.total)
                                  .then((value) {
                                cartData.clear();
                                setState(() {
                                  _isLoading = false;
                                });
                              });
                              // clear the cart after placing the order
                            },
                            child: Text(
                              'ORDER NOW',
                              style: TextStyle(color: Colors.purple),
                            ))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: cartData.items.length,
                      itemBuilder: (ctx, index) {
                        return CartItemWidget(
                          // we have to add .values.toList() coz items is a MAP
                          // .values return a iterable and then we convert it to a list
                          imageUrl:
                              cartData.items.values.toList()[index].imageUrl,
                          id: cartData.items.values.toList()[index].id,
                          price: cartData.items.values.toList()[index].price,
                          quantity:
                              cartData.items.values.toList()[index].quantity,
                          title: cartData.items.values.toList()[index].title,
                          productId: cartData.items.keys.toList()[index],
                        );
                      }),
                )
              ]));
  }
}
