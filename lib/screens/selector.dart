import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'triangle_shape.dart';

class Selector extends StatelessWidget {
  int length;

  Selector(
    this.length, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
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
            ? SizedBox(
                width: length == 1 ? Get.width * 0.48 : Get.width * 0.35,
                height: length == 1 ? Get.height * 0.17 : Get.height * 0.08)
            : SizedBox(
                width: length == 1 ? Get.width * 0.3 : Get.width * 0.22,
                height: length == 1 ? Get.height * 0.29 : Get.height * 0.13),
        RotatedBox(
          quarterTurns: 90,
          child: CustomPaint(
            size: const Size(25, 30),
            painter: TrianglePainter(
              strokeColor: Colors.white,
              strokeWidth: 10,
              paintingStyle: PaintingStyle.fill,
            ),
          ),
        ),
      ],
    );
  }
}
