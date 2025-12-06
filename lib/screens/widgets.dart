import "package:flutter/material.dart";
import "package:carousel_slider/carousel_slider.dart";

import "package:citysewa/screens/service_screen.dart" show ServiceScreen;

const appIcon = "lib/assets/app_icon.png";

class Carousel extends StatelessWidget {
  final List itemList;
  final List<Widget> items;
  Carousel({super.key, required this.itemList})
    : items = itemList.map((image) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.25),
                offset: Offset(0, 2),
                blurRadius: 6,
                spreadRadius: 0,
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.network(image, fit: BoxFit.cover),
          ),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(autoPlay: true),
    );
  }
}

class ServiceCarousel extends StatelessWidget {
  final List itemList;
  final List<Widget> items;
  final BuildContext context;
  ServiceCarousel({super.key, required this.context, required this.itemList})
    : items = itemList.map((item) {
        return InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ServiceScreen(serviceId: item["service"]),
              ),
            );
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.25),
                  offset: Offset(0, 2),
                  blurRadius: 6,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Image.network(
                item["thumbnail"]["image"],
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      }).toList();

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: items,
      options: CarouselOptions(autoPlay: true),
    );
  }
}
