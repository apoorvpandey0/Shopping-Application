import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/order.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders-screen';
  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('My Orders'),
      ),
      body: ListView.builder(
          itemCount: orderData.orders.length,
          itemBuilder: (_, index) => OrderWidget(
                amount: orderData.orders[index].amount,
                created: orderData.orders[index].created,
                items: orderData.orders[index].items,
              )),
    );
  }
}

class OrderWidget extends StatefulWidget {
  final amount;
  final items;
  final created;
  OrderWidget({this.amount, this.items, this.created});

  @override
  _OrderWidgetState createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: <Widget>[
          ListTile(
              title: Text("Order ID: #i8322f"),
              subtitle:
                  Text("Placed: ${DateFormat.yMMMd().format(widget.created)}"),
              trailing: IconButton(
                  onPressed: () {
                    setState(() {
                      print(widget.items);
                      _expanded = !_expanded;
                    });
                  },
                  icon: Icon(_expanded
                      ? Icons.arrow_drop_up
                      : Icons.arrow_drop_down))),
          if (_expanded)
            Container(
                height: min(widget.items.length * 20.0 + 80, 180.0),
                child: ListView(
                  children: <Widget>[
                    ...widget.items.map((prod) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                prod.title,
                                style: TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.bold),
                              ),
                              Text('${prod.quantity}x ${prod.price}')
                            ],
                          ),
                        ))
                  ],
                ))
        ],
      ),
    );
  }
}
