import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  // final BuildContext userProductsScreenContext;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    // final userProductsScreenContext = context;
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                print("In UserPItem Widget -> UPDATE");
                Navigator.of(context)
                    .pushNamed(EditProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context, listen: false)
                    .deleteProduct(id)
                    .catchError((error) {
                  print("Error aagya");
                  // showDialog(
                  //     context: userProductsScreenContext,
                  //     child: AlertDialog(
                  //       content: Text('Deletion Failed'),
                  //       actions: [
                  //         FlatButton(
                  //             onPressed: () {
                  //               // Navigator.of(userProductsScreenContext).pop();
                  //             },
                  //             child: Text('Okay'))
                  //       ],
                  //     ));
                });
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
