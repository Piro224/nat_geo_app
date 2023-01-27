import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nat_geo_app/models/animals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.models});
  final Models models;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var activeSliderIndex = Models().animals.isNotEmpty ? 0:1;
  var currentPage = 0;
  var activeNavBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    var sliderHeight = height * 0.45;
    var playButtonSize = 50.0;
    var padding = 24.0;
    var radius = 30.0;
    var carouselWidthPortion = 0.7;
    var recentStoriesHeight = height * 0.3;

    return DefaultTabController(
      initialIndex: 0,
      length: 5,
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          body: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Logo and search button
                _buildGeoheader(),
                const SizedBox(height: 10),

                //Popular Stories

                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Popular Stories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),

                //Slider
                CarouselSlider(
                  options: CarouselOptions(
                      height: sliderHeight,
                      enableInfiniteScroll: true,
                      enlargeCenterPage: true,
                      viewportFraction: carouselWidthPortion,
                      onPageChanged: (index, reason) {
                        setState(() {
                          currentPage = index;
                        });
                      },
                      autoPlay: true),
                  items: [
                    ...List.generate(widget.models.animals.length, ((index) {
                      return Slider(
                        sliderHeight: sliderHeight,
                        width: width,
                        radius: radius,
                        padding: padding,
                        imagePath: widget.models.animals[index][1],
                        text: widget.models.animals[index][0],
                      );
                    }))
                  ],
                ),

                //Indicator
                const SizedBox(height: 15),
                // Center(
                //   child: AnimatedSmoothIndicator(
                //     activeIndex: 0,
                //     count: widget.models.animals.length,
                //     effect: const ExpandingDotsEffect(
                //       activeDotColor: Colors.yellow,
                //       dotColor: Colors.white,
                //       dotWidth: 18,
                //       dotHeight: 8,
                //     ),
                //   ),
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...List.generate(
                      widget.models.animals.length,
                      ((index) {
                        return _buildIndicator(index: index);
                      }),
                    ),
                  ],
                ),

                const SizedBox(height: 15),

                //Recent Stories Title
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Recent Stories',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
                const SizedBox(height: 15),

                //Recent Stories
                ...List.generate(widget.models.animals.length, (index) {
                  return Videos(
                    width: width,
                    padding: padding,
                    recentStoriesHeight: recentStoriesHeight,
                    radius: radius,
                    playButtonSize: playButtonSize,
                    imagePath: widget.models.animals[index][1],
                    text: widget.models.animals[index][0],
                  );
                }),
              ],
            ),
          ),
          bottomNavigationBar: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  labelPadding: const EdgeInsets.all(8),
                  indicator: UnderlineTabIndicator(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(width: 5.0, color: Colors.yellow),
                      insets: const EdgeInsets.symmetric(horizontal: 36.0)),
                  indicatorPadding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 8,
                  ),
                  isScrollable: false,
                  labelColor: Colors.yellow,
                  unselectedLabelColor: Colors.white,
                  tabs: const [
                    Tab(
                        icon: Icon(
                      CupertinoIcons.house_alt_fill,
                      size: 28,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.label,
                      size: 28,
                    )),
                    Tab(
                        icon: Icon(
                      CupertinoIcons.bell,
                      size: 28,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.location_on,
                      size: 28,
                    )),
                    Tab(
                        icon: Icon(
                      Icons.settings,
                      size: 28,
                    )),
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildIndicator({required int index}) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        margin: const EdgeInsets.only(right: 5),
        height: 8,
        width: currentPage == index ? 35 : 14,
        decoration: BoxDecoration(
          color: currentPage == index ? Colors.yellow : Colors.white,
          borderRadius: BorderRadius.circular(4),
        ),
      ),
    );
  }

  Row _buildGeoheader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            'assets/natgeo.png',
            fit: BoxFit.cover,
            width: 120,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.yellow,
              shape: BoxShape.circle,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Icon(
                Icons.search_sharp,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Videos extends StatelessWidget {
  const Videos({
    super.key,
    required this.width,
    required this.padding,
    required this.recentStoriesHeight,
    required this.radius,
    required this.playButtonSize,
    required this.imagePath,
    required this.text,
  });

  final double width;
  final double padding;
  final double recentStoriesHeight;
  final double radius;
  final double playButtonSize;
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(6.0),
              child: Container(
                width: width,
                // clipBehavior: Clip.hardEdge,
                margin: EdgeInsets.symmetric(horizontal: padding),
                height: recentStoriesHeight,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                    child: Container(
                      width: width,
                      padding: EdgeInsets.all(padding),
                      child: Text(
                        text,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: recentStoriesHeight * 0.5 - padding * 0.5 - 8,
              left: (width - 2 * padding) * 0.5 - 8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.play_circle_fill,
                      color: Colors.yellow,
                      size: playButtonSize,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class Slider extends StatelessWidget {
  const Slider({
    super.key,
    required this.sliderHeight,
    required this.width,
    required this.radius,
    required this.padding,
    required this.imagePath,
    required this.text,
  });

  final double sliderHeight;
  final double width;
  final double radius;
  final double padding;
  final String imagePath;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: sliderHeight,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: Colors.yellow,
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(image: AssetImage(imagePath), fit: BoxFit.cover),
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(
              width: width,
              padding: EdgeInsets.all(padding),
              child: Text(
                text,
                textAlign: TextAlign.left,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
