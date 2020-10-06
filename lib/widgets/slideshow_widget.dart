import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Slideshow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(height: 200.0, enlargeCenterPage: true),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(color: Colors.amber),
                  child: Center(
                    child: Text(
                      'OFFER $i',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  )),
            );
          },
        );
      }).toList(),
    );
  }
}
