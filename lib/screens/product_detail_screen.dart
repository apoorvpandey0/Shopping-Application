import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/products.dart';

class ProductDetailScreen extends StatelessWidget {
  static const routeName = '/product-detail';
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as String;
    final product =
        // We can listen to providers in detasil screen because it is instantiated in Material app which has instantiated Products Provider
        // listen = false because w donot want to rebuild the entire detail page when data in Products class changes
        Provider.of<Products>(context, listen: false).findById(args);
    return Scaffold(
        // appBar: AppBar(
        //   title: Text(product.title),
        // ),
        body: CustomScrollView(slivers: [
      SliverAppBar(
        pinned: true,
        expandedHeight: 400,
        flexibleSpace: FlexibleSpaceBar(
          title: Text(product.title),
          background: Hero(
              // transitionOnUserGestures: true,
              tag: product.id,
              child: Center(child: Image.network(product.imageUrl))),
        ),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        // Text(
        //   product.title,
        //   style: TextStyle(fontSize: 20),
        // ),
        // Divider(),
        Text(
          "Description Data with favs and add \nto cart button will come here",
          textAlign: TextAlign.center,
        ),
        SizedBox(height: 800)
      ]))
    ]));
  }
}
