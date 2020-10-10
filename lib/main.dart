import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/order.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/auth_screen.dart';

import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/screens/intro_screen.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_overview_screen.dart';
import 'package:shop_app/screens/splash_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Use multiprovider to use multiple providers at same level in widget tree
    return MultiProvider(
        providers: [
          // We have instantiated MaterialApp with a provider of class products
          // All its children can listen to this provider using Proviider.of<Products>(context)
          // children of MaterialApp as we call them are: ProductsOverviewScreen(),ProductDetailsScreen()
          ChangeNotifierProvider(
            create: (ctx) => Auth(),
          ),

          //Products Provider
          ChangeNotifierProxyProvider<Auth, Products>(
              create: (
                ctx,
              ) =>
                  Products(),
              update: (ctx, authObject, previousProductsObject) => Products()
                ..updateProxyMethod(
                    authObject.token,
                    previousProductsObject.items == null
                        ? []
                        : previousProductsObject.items,
                    authObject.userId)),

          // Cart Provider
          ChangeNotifierProvider(
            create: (ctx) => Cart(),
          ),

          //Orders provider
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (ctx) => Orders(),
            update: (ctx, auth, previousOrderObject) => Orders()
              ..updateProxyMethod(
                  auth.token, previousOrderObject.orders, auth.userId),
          ),
        ],

        // Actual Application
        child: Consumer<Auth>(
          builder: (context, auth, child) => MaterialApp(
            theme: ThemeData(primarySwatch: Colors.purple, fontFamily: 'Lato'),
            title: 'Flutter Demo',
            // home: ProductOverviewScreen(),
            home: auth.isAuth
                ? ProductOverviewScreen()
                : FutureBuilder(
                    future: auth.tryAutoLogin(),
                    builder: (ctx, snapshot) =>
                        snapshot.connectionState == ConnectionState.waiting
                            ? SplashScreen()
                            : AuthScreen(),
                  ),
            routes: {
              IntroScreen.routeName: (ctx) => IntroScreen(),
              ProductOverviewScreen.routeName: (ctx) => ProductOverviewScreen(),
              ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrdersScreen.routeName: (ctx) => OrdersScreen(),
              UserProductsScreen.routeName: (ctx) => UserProductsScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
