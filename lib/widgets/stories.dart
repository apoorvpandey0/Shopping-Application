import 'package:flutter/material.dart';

class Stories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Stories', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (ctx, index) {
                return StoryItem();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StoryItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
          return StoryScreen();
        }));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                // margin: EdgeInsets.symmetric(horizontal: 5),
                color: Colors.amber,
                child: Image.network(
                  'https://image.freepik.com/free-vector/portrait-african-american-woman-profile-avatar-young-black-girl_102172-418.jpg',
                ),
                // These are the dimensions of the image
                // height: 80,
                width: 70,
              ),
            ),
            Text('naam'),
          ],
        ),
      ),
    );
  }
}

class StoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("STORYYYYYYY"),
      ),
    );
  }
}
