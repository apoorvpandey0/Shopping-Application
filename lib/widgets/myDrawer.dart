// import 'dart:';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/auth.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class MyDrawer extends StatelessWidget {
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.75,
      child: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            // Container lets us decide the height of the Header Box
            Container(
              height: 250,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: Container(
                  child: Column(
                    children: <Widget>[
                      // Profile pic
                      CircleAvatar(
                          radius: 60,
                          backgroundImage: NetworkImage(
                              'https://randomuser.me/api/portraits/lego/0.jpg')),

                      // Users name
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            FlatButton(
                              onPressed: () {},
                              child: Text(
                                'Majnu Bhaai',
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                    letterSpacing: 1),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),

            // Internships and settings tab section
            ListTile(
              leading: Icon(
                Icons.check,
                size: 30,
              ),
              title: Text('My orders', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(OrdersScreen.routeName);
              },
            ),

            ListTile(
              leading: Icon(
                Icons.filter,
                size: 30,
              ),
              title: Text('My Products', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(UserProductsScreen.routeName);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.exit_to_app,
                size: 30,
              ),
              title: Text('Logout', style: TextStyle(fontSize: 20)),
              onTap: () {
                Navigator.of(context).pop();
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),

            ListTile(
              leading: Icon(
                Icons.call,
                size: 30,
              ),
              onTap: () async {
                final message =
                    "नमस्कार, आप Bazaarhaat ग्राहक सहायता केंद्र पर पहुँच गए हैं। अपनी समस्या यहाँ टाइप करें।";
                final url =
                    'https://wa.me/+917898812907?text=${Uri.encodeFull(message)}';
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              title: Text('Contact Us', style: TextStyle(fontSize: 20)),
              subtitle: Text(
                'Mon-Fri,10 AM-5PM',
                style: TextStyle(fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
