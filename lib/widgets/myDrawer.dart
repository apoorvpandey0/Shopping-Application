import 'package:flutter/material.dart';

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
              leading: Icon(Icons.send),
              title: Text('Internships'),
              onTap: () {},
              selected: _isSelected,
            ),
            ListTile(
              leading: Icon(Icons.assignment),
              title: Text('My Applications'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('Messages'),
            ),
            ListTile(
              leading: Icon(Icons.assignment_ind),
              title: Text('Edit Resume'),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
            ),
            ListTile(
              leading: Icon(Icons.call),
              title: Text('Contact Us'),
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
