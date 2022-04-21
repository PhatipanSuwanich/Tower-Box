import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';

class RectangularShape extends StatefulWidget {
  Color color;

  RectangularShape({
    Key? key,
    required this.color,
  }) : super(key: key);

  @override
  _RectangularShapeState createState() => _RectangularShapeState();
}

class _RectangularShapeState extends State<RectangularShape> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).orientation == Orientation.portrait
        ? Get.width
        : widthGrey;

    return Container(
      key: widget.key,
      margin: const EdgeInsets.only(bottom: 10),
      height: 64,
      width: width * 0.3,
      decoration: BoxDecoration(
        color: widget.color,
        border: Border.all(width: widthBorder),
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
      ),
    );
  }
}
