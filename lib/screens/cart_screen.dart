import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart-screen';
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(title: Text("My Cart")),
        body: Column(children: <Widget>[
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
                      '\$${cartData.total()}',
                      style: TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.purple,
                  ),
                  FlatButton(
                      onPressed: () {},
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
                    imageUrl: cartData.items.values.toList()[index].imageUrl,
                    id: cartData.items.values.toList()[index].id,
                    price: cartData.items.values.toList()[index].price,
                    quantity: cartData.items.values.toList()[index].quantity,
                    title: cartData.items.values.toList()[index].title,
                    productId: cartData.items.keys.toList()[index],
                  );
                }),
          )
        ]));
  }
}
