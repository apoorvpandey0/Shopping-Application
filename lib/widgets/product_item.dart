import 'package:flutter/material.dart';

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
    return GridTile(
      child: Image.network(imageUrl),
      footer: GridTileBar(
          leading: Icon(Icons.favorite),
          subtitle: Text("INR $price"),
          backgroundColor: Colors.black38,
          title: Text(title),
          trailing: Icon(
            Icons.add_shopping_cart,
          )),
    );
  }
}
