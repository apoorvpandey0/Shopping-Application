import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
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
                //   Future<bool> ans = showDialog(
                //       context: context,
                //       builder: (ctx) => AlertDialog(
                //               title: Text(
                //                 'Confirm karo',
                //                 style: TextStyle(
                //                   fontSize: 30,
                //                 ),
                //               ),
                //               content: Text(
                //                 "Sure want to remove this product forever?",
                //                 style: TextStyle(
                //                   fontSize: 15,
                //                 ),
                //               ),
                //               actions: <Widget>[
                //                 FlatButton(
                //                     child: Text('Hao'),
                //                     onPressed: () {
                //                       Navigator.of(context).pop(true);
                //                     }),
                //                 FlatButton(
                //                     child: Text('Nopes'),
                //                     onPressed: () {
                //                       Navigator.of(context).pop(false);
                //                     })
                //               ]));
                // if (ans == true) {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
                // } else {
                // return;
                // }
              },
              color: Theme.of(context).errorColor,
            ),
          ],
        ),
      ),
    );
  }
}
