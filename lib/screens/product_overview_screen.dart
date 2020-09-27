import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_screen.dart';
import 'package:shop_app/screens/product_detail_screen.dart';
import 'package:shop_app/widgets/badge.dart';
import 'package:shop_app/widgets/myDrawer.dart';
import 'package:shop_app/widgets/product_item.dart';

class ProductOverviewScreen extends StatefulWidget {
  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavsOnly = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MyDrawer(),
      appBar: AppBar(
        elevation: 5,
        actions: <Widget>[
          Consumer<Cart>(
            // we used the 3rd argument here to further narrow down the parts that dont need a rebuild
            builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.getCartItemsCount().toString(),
                color: Colors.deepOrange),
            child: IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                }),
          ),
          PopupMenuButton(
            onSelected: (int selected) {
              if (selected == 0) {
                setState(() {
                  _showFavsOnly = true;
                });
              }
              if (selected == 1) {
                setState(() {
                  _showFavsOnly = false;
                });
              }
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text("Favourites"),
                value: 0,
              ),
              PopupMenuItem(
                child: Text('Show All'),
                value: 1,
              )
            ],
          )
        ],
        title: Text('Shop app'),
      ),
      body: ProductsGrid(_showFavsOnly),
    );
  }
}

class ProductsGrid extends StatelessWidget {
  bool showFavsOnly = false;
  ProductsGrid(this.showFavsOnly);
  @override
  Widget build(BuildContext context) {
    // The provider class Products that we want to listen to
    final productsData = Provider.of<Products>(context);
    final loadedProducts =
        showFavsOnly ? productsData.favItems() : productsData.items;
    return GridView.builder(
        padding: EdgeInsets.all(8),
        itemCount: loadedProducts.length,
        // TO NOTE: This is FixedCrossAxisContent, in the Meal app we used Extent class
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            // crossAxiscount is amount of columns you want to have
            crossAxisCount: 2,
            // Spacing between columns
            crossAxisSpacing: 6,
            // spacing b/w rows
            mainAxisSpacing: 10,
            // Aspect ratio of dimensions of your each element in the grid
            childAspectRatio: 3 / 2),
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, i) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(ProductDetailScreen.routeName,
                  arguments: loadedProducts[i].id);
            },
            child: ChangeNotifierProvider.value(
              // It is recommended to use DOTvalue method where we are in a list or a grid view
              // DOTvalue cleans up the products value if the screen gets replaced
              value: loadedProducts[i],
              child: ProductItem(
                  title: loadedProducts[i].title,
                  imageUrl: loadedProducts[i].imageUrl,
                  id: loadedProducts[i].id,
                  price: loadedProducts[i].price),
            ),
          );
        });
  }
}
