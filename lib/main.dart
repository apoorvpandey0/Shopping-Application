import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use multiprovider to use multiple providers at same level in widget tree
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          // We have instantiated MaterialApp with a provider of class products
          // All its children can listen to this provider using Proviider.of<Products>(context)
          // children of MaterialApp as we call them are: ProductsOverviewScreen(),ProductDetailsScreen()
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Lato'),
        title: 'Flutter Demo',
        home: ProductOverviewScreen(),
        routes: {
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
          CartScreen.routeName: (ctx) => CartScreen()
        },
      ),
    );
  }
}
