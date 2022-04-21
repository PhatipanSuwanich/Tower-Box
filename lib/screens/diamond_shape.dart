import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class DiamondShape extends StatefulWidget {
  var color;

  DiamondShape({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  _DiamondShapeState createState() => _DiamondShapeState();
}

class _DiamondShapeState extends State<DiamondShape> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).orientation == Orientation.portrait
        ? Get.width
        : widthGrey;

    return Transform.rotate(
      key: widget.key,
      angle: pi / 4,
      child: Container(
        margin: const EdgeInsets.only(bottom: 40, top: 40),
        height: width * 0.3,
        width: width * 0.3,
        decoration: BoxDecoration(
          color: widget.color,
          border: Border.all(width: widthBorder),
        ),
      ),
    );
  }
}
