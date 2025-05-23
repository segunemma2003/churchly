import 'package:flutter/material.dart';
import 'package:nylo_framework/nylo_framework.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, this.height, this.width});
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "logoblack.png",
      height: height ?? 250,
      width: width ?? 250,
    ).localAsset();
  }
}
