import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final price;
  final id;
  final quantity;
  final productId;
  final imageUrl;
  final title;
  CartItemWidget(
      {@required this.imageUrl,
      @required this.id,
      @required this.productId,
      @required this.price,
      @required this.quantity,
      @required this.title});
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Dismissible(
        key: ValueKey(id),
        // endTostart meand RTL
        direction: DismissDirection.endToStart,
        onDismissed: (direction) {
          print(productId);
          cartData.deleteItem(productId);
        },
        background: Container(
            alignment: Alignment.centerRight,
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Icon(
                Icons.delete,
                color: Colors.white,
                size: 30,
              ),
            )),
        child: Card(
            elevation: 3,
            child: ListTile(
              leading: Image.network(imageUrl),
              title: Text(title),
              subtitle: Text(
                'Total:\$${(price * quantity).toString()}',
                style: TextStyle(fontSize: 13),
              ),
              trailing: Text('\$${(price * quantity).toString()}'),
            )),
      ),
    );
  }
}
