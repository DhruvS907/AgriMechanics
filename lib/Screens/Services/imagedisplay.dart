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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Widget widget1 = FadeInImage(
      placeholder: AssetImage('assets/images/BackgroundImage1.avif'),
      image: NetworkImage(
        widget.imagePath1 == "" ? widget.imagePath2 : widget.imagePath1,
      ),
      fit: BoxFit.fill,
      fadeInCurve: Curves.easeInCirc,
      placeholderFit: BoxFit.fill,
      width: size.width * 0.95,
      height: 250,
    );
    Widget widget2 = Stack(children: [
      Positioned.fill(
        child: CarouselSlider(
            items: [
              FadeInImage(
                placeholder: AssetImage('assets/images/BackgroundImage1.avif'),
                image: NetworkImage(
                  widget.imagePath1,
                ),
                fit: BoxFit.fill,
                fadeInCurve: Curves.easeInCirc,
                placeholderFit: BoxFit.fill,
                width: size.width * 0.95,
                height: 250,
              ),
              FadeInImage(
                placeholder: AssetImage('assets/images/BackgroundImage1.avif'),
                image: NetworkImage(
                  widget.imagePath2,
                ),
                fit: BoxFit.fill,
                fadeInCurve: Curves.easeInCirc,
                placeholderFit: BoxFit.fill,
                width: size.width * 0.95,
                height: 250,
              ),
            ],
            carouselController: carouselController,
            options: CarouselOptions(
                height: 250,
                viewportFraction: 1,
                scrollDirection: Axis.horizontal,
                enableInfiniteScroll: false,
                pauseAutoPlayInFiniteScroll: true,
                autoPlayAnimationDuration: Duration(seconds: 2),
                autoPlay: true)),
      )
    ]);
    if (widget.imagePath1 == "" || widget.imagePath2 == "") {
      return widget1;
    } else {
      return widget2;
    }
  }
}
