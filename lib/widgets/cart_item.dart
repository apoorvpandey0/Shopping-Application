import 'package:flutter/cupertino.dart';
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

        // Shows a dialog box to confirm deletion
        confirmDismiss: (direction) {
          // confirmsDismiss needs a Future object in return
          return showCupertinoDialog(
              context: context,
              builder: (ctx) => CupertinoAlertDialog(
                    title: Text(
                      'Confirm karo',
                      style: TextStyle(
                        fontSize: 30,
                      ),
                    ),
                    content: Text(
                      "Cart item delete kar dun?\n",
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    ),
                    actions: <Widget>[
                      FlatButton(
                          child: Text('Hao'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          }),
                      FlatButton(
                        child: Text('Nahi'),
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                      )
                    ],
                  ));
        },

        // What happens when user says YES
        onDismissed: (direction) {
          // print(productId);
          cartData.deleteItem(productId);
        },

        // The RED color that appears ith the trash icon when we slide the CartItem
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

        // The acutal CartItem Card that holds all the things
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
