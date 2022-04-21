import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:get/get.dart';

import 'screens/home.dart';

void main() {
  runApp(GetMaterialApp(
    // navigatorObservers: [FlutterSmartDialog.observer],
    // builder: FlutterSmartDialog.init(),
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    getPages: [
      GetPage(name: '/', page: () => Home()),
    ],
  ));
}

