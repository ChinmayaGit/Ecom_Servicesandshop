import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
class Carousal{
  Widget carouselimgs = SizedBox(
      height: 200.0,
      width: 350.0,
      child: Carousel(
        images: [

          AssetImage('assets/img/Carouselimgs/N/Solarpannel.jpg'),
          AssetImage('assets/img/Carouselimgs/N/Washingmechine.jpg'),
          AssetImage('assets/img/Carouselimgs/N/lightfan.jpg'),
          AssetImage('assets/img/Carouselimgs/N/bestwater.jpg'),
          AssetImage('assets/img/Carouselimgs/N/AirConditioner.jpg'),
        ],
        dotSize: 6.0,
        dotSpacing: 15.0,
        dotColor: Colors.lightBlueAccent,
        indicatorBgPadding: 30.0,
        dotBgColor: Colors.transparent,
        borderRadius: true,
        moveIndicatorFromBottom: 180.0,
        noRadiusForIndicator: true,
        overlayShadow: true,
        overlayShadowColors: Colors.white,
        overlayShadowSize: 0.7,
        autoplay: true,
        dotIncreasedColor: Colors.lightBlueAccent,

      ));

}