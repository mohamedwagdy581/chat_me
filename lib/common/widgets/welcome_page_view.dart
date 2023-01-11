import 'package:flutter/material.dart';

Container welcomePageView({required String image, Widget? child}) => Container(
  height: double.infinity,
  width: double.infinity,
  decoration: BoxDecoration(
    image: DecorationImage(
      fit: BoxFit.fill,
      image: AssetImage(
        image,
      ),
    ),
  ),
  child: child,
);