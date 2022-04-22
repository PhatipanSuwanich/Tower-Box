import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';

import '../constants.dart';
import '../controllers/box.dart';
import '../controllers/time.dart';
import 'box_shape.dart';
import 'diamond_shape.dart';
import 'selector.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final BoxController _boxController = Get.put(BoxController());
  final TimeController _timeController = Get.put(TimeController());
  late Timer _timerDuration, _timer, _timeTotal;
  late bool status, oneTime;
  bool clickL = false;
  bool clickR = false;
  final GlobalKey<AnimatedListState> listKey = GlobalKey();

  customToast(text) => Container(
        height: 150,
        width: 300,
        color: Colors.black87,
        alignment: Alignment.center,
        child: Text(text,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 20)),
      );

  @override
  void initState() {
    super.initState();

    status = false;
    oneTime = false;

    for (int i = 0; i < 9; i++) {
      int random = Random().nextInt(2);
      _boxController.listBox.add(
        RectangularShape(
          key: UniqueKey(),
          color: colors[random],
        ),
      );
      _boxController.listColorsBox.add(colors[random]);
    }

    _boxController.listBox.add(
      DiamondShape(key: UniqueKey(), color: colors[2]),
    );
    _boxController.listColorsBox.add(colors[2]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.of(context).orientation == Orientation.portrait
          ? portrait()
          : landscape(),
    );
  }

  Widget portrait() {
    return Column(
      children: [
        Container(
          width: Get.width,
          height: Get.height * 0.85,
          color: Colors.grey,
          alignment: Alignment.bottomCenter,
          child: game_widget(),
        ),
        Container(
          height: Get.height * 0.15,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              btnCircle(
                  tag: 0,
                  color: colors[0],
                  onLongPress: () {
                    if (clickL && clickR) {
                      // if (_boxController.listColorsBox[0] == colors[2]) {
                      // removeAnimation(colors[2]);
                      // }
                    } else if (_boxController.listColorsBox[0] == colors[0]) {
                      removeAnimation(colors[0]);
                    }
                  }),
              Obx(() => Text(_timeController.sec.toString())),
              btnCircle(
                tag: 1,
                color: colors[1],
                onLongPress: () {
                  if (clickL && clickR) {
                    if (_boxController.listColorsBox[0] == colors[2]) {
                      removeAnimation(colors[2]);
                    }
                  } else if (_boxController.listColorsBox[0] == colors[1]) {
                    removeAnimation(colors[1]);
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget landscape() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: widthBox18,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(_timeController.sec.toString())),
              SizedBox(height: 80),
              btnCircle(
                  tag: 0,
                  color: colors[0],
                  onLongPress: () {
                    if (clickR && clickL) {
                      // if (_boxController.listColorsBox[0] == colors[2]) {
                      //   removeAnimation(colors[2]);
                      // }
                    } else if (_boxController.listColorsBox[0] == colors[0]) {
                      removeAnimation(colors[0]);
                    }
                  }),
              SizedBox(height: 30),
            ],
          ),
        ),
        Container(
          width: widthGrey,
          height: Get.height,
          color: Colors.grey,
          child: game_widget(),
        ),
        Container(
          width: widthBox18,
          height: Get.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() => Text(_timeController.sec.toString())),
              SizedBox(height: 80),
              btnCircle(
                tag: 1,
                color: colors[1],
                onLongPress: () {
                  if (clickR && clickL) {
                    if (_boxController.listColorsBox[0] == colors[2]) {
                      removeAnimation(colors[2]);
                    }
                  } else if (_boxController.listColorsBox[0] == colors[1]) {
                    removeAnimation(colors[1]);
                  }
                },
              ),
              SizedBox(height: 30),
            ],
          ),
        ),
      ],
    );
  }

  Obx game_widget() {
    return Obx(() {
      if (_boxController.listBox.isEmpty) {
        return Container(
            margin: MediaQuery.of(context).orientation == Orientation.portrait
                ? const EdgeInsets.symmetric(vertical: 180, horizontal: 50)
                : const EdgeInsets.symmetric(vertical: 100, horizontal: 50),
            width: Get.width,
            height: Get.height,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(width: widthBorder),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Total Time",
                    style:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Text("${_timeController.total}s",
                    style: const TextStyle(fontSize: 24)),
              ],
            ));
      } else {
        return AnimatedList(
          key: listKey,
          shrinkWrap: true,
          reverse: true,
          padding: const EdgeInsets.only(bottom: 20),
          initialItemCount: _boxController.listBox.length,
          itemBuilder: (BuildContext context, int index, animated) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                if (index == 0)
                  Selector(_boxController.listBox.length)
                else
                  SizedBox(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [_boxController.listBox[index]],
                ),
              ],
            );
          },
        );
      }
    });
  }

  void removeAnimation(color) {
    listKey.currentState?.removeItem(0, (_, animation) {
      return SizeTransition(
          sizeFactor: animation,
          child: SizedBox(
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RectangularShape(color: color),
              ],
            ),
          ));
    }, duration: const Duration(milliseconds: 300));

    _boxController.listBox.removeAt(0);
    _boxController.listColorsBox.removeAt(0);

    if (_boxController.listColorsBox.isEmpty) {
      _timeTotal.cancel();
    } else if (_boxController.listColorsBox.length == 1) {
      showToastWidget(
          customToast("กดสองปุ่ม ค้างไว้ 2 วิ\nเพื่อทำลาย Block สุดท้าย"));
    }
  }

  Widget btnCircle({
    required Function() onLongPress,
    required Color color,
    required int tag,
  }) {
    return GestureDetector(
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
          border: Border.all(width: widthBorder),
        ),
      ),
      onTap: () {
        showToastWidget(customToast("กดปุ่มสีที่ตรงกัน\nค้างไว้ 2 วินาที\nเพื่อทำลายบล็อค"));
      },
      onLongPress: () {
        if (tag == 0) {
          clickR = true;
        } else if (tag == 1) {
          clickL = true;
        }
        startCountdown();
        _timerDuration = Timer(Duration(seconds: 2), () => onLongPress());
      },
      onLongPressEnd: (_) {
        resetTimer();
        if (tag == 0) {
          clickR = false;
        } else if (tag == 1) {
          clickL = false;
        }
      },
    );
  }

  /// Timer related methods ///
  void startCountdown() {
    if (!status) {
      status = true;
      _timeTotal = Timer.periodic(Duration(seconds: 1), (_) {
        _timeController.total++;
        // print(_timeController.total);
      });
    }
    if (!oneTime) {
      oneTime = true;
      _timer = Timer.periodic(Duration(seconds: 1), (_) {
        if (_timeController.sec > 0) {
          _timeController.sec--;
        } else {
          _timer.cancel();
        }
      });
    }
  }

  void resetTimer() {
    oneTime = false;
    _timer.cancel();
    _timeController.sec.value = 2;
    _timerDuration.cancel();
  }
}
