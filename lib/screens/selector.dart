import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants.dart';
import 'triangle_shape.dart';

class Selector extends StatelessWidget {
  int length;

  Selector(
    this.length, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).orientation == Orientation.portrait
        ? Get.width
        : widthGrey;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomPaint(
          size: const Size(25, 30),
          painter: TrianglePainter(
            strokeColor: Colors.white,
            strokeWidth: 10,
            paintingStyle: PaintingStyle.fill,
          ),
        ),
        MediaQuery.of(context).orientation == Orientation.portrait
            ? Container(
                margin: const EdgeInsets.only(bottom: 11),
                width: length == 1 ? Get.width * 0.48 : Get.width * 0.35,
                height: length == 1 ? width * 0.44 : 64)
            : Container(
                margin: const EdgeInsets.only(bottom: 11),
                width: length == 1 ? Get.width * 0.3 : Get.width * 0.22,
                height: length == 1 ? width * 0.44 : 64),
        RotatedBox(
          quarterTurns: 90,
          child: CustomPaint(
            size: const Size(25, 30),
            painter: TrianglePainter(
              strokeColor: Colors.white,
              strokeWidth: 1,
              paintingStyle: PaintingStyle.fill,
            ),
          ),
        ),
      ],
    );
  }
}
