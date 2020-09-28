import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final String id;
  final String imageUrl;
  final double price;
  ProductItem(
      {@required this.title,
      @required this.id,
      @required this.imageUrl,
      @required this.price});
  @override
  Widget build(BuildContext context) {
    // We can listen to our provider class Product with the ChangeNotifier that we set up in GridView

    // Method 1 of listening to our chaqnges in Product provider
    // final product = Provider.of<Product>(context);

    // Using this will rebuild the entire ProductItem widget irrespective of whatever changed in the Product model
    // We can use an alternative way using "Consumer" wich will only re-render the specific like button instead of the entire build method

    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: GridTile(
        child: Image.network(imageUrl),
        footer: GridTileBar(
            // Method 2 using Consumer class which will re render only the like button
            leading: Consumer<Product>(
              builder: (context, product, child) => IconButton(
                icon: product.isfavourite
                    ? Icon(
                        Icons.favorite,
                        color: Colors.red,
                      )
                    : Icon(
                        Icons.favorite_border,
                      ),
                onPressed: product.toggleFavs,
              ),
            ),
            subtitle: Text("\$$price"),
            backgroundColor: Colors.black38,
            title: Text(title),
            trailing: Consumer<Cart>(
              builder: (_, cart, _2) => IconButton(
                onPressed: () {
                  cart.addItem(id, price, title, imageUrl);
                  // This removes any previous snackbars
                  Scaffold.of(context).hideCurrentSnackBar();
                  // This Scaffold will reach out to the nearest Scaffold in widget tree and show a Snackbar there
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text('$title added to cart'),
                        FlatButton(
                            onPressed: () {
                              cart.removeOneItem(id);
                              Scaffold.of(context).hideCurrentSnackBar();
                            },
                            child: Text('UNDO',
                                style: TextStyle(color: Colors.deepOrange)))
                      ],
                    ),
                  ));
                },
                icon: Icon(Icons.add_shopping_cart),
              ),
            )),
      ),
    );
  }
}
