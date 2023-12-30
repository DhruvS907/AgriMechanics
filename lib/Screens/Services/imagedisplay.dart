import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class imagedisplay extends StatefulWidget {
  late String imagePath1;
  late String imagePath2;
  imagedisplay({
    super.key,
    required this.imagePath1,
    required this.imagePath2,
  });

  @override
  State<imagedisplay> createState() => _imagedisplayState();
}

class _imagedisplayState extends State<imagedisplay> {
  final CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    Widget widget1 = SizedBox(
        height: 200,
        width: 200,
        child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1)),
            child: Image(
                image: NetworkImage(widget.imagePath1),
                height: 400,
                width: 200,
                fit: BoxFit.cover)));
    Widget widget2 = Stack(children: [
      SizedBox(
          height: 200,
          width: 200,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1)),
            child: CarouselSlider(
                items: [
                  Image(
                      image: NetworkImage(widget.imagePath1),
                      fit: BoxFit.cover,
                      height: 400,
                      width: 200),
                  Image(
                    image: NetworkImage(widget.imagePath2),
                    height: 400,
                    width: 200,
                    fit: BoxFit.cover,
                  )
                ],
                carouselController: carouselController,
                options: CarouselOptions(
                    scrollDirection: Axis.horizontal, autoPlay: false)),
          ))
    ]);
    if (widget.imagePath1 == "" || widget.imagePath2 == "") {
      return widget1;
    } else {
      return widget2;
    }
  }
}
