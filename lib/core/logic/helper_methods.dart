import 'dart:async';
import 'package:flutter/material.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void goTo(Widget page, {bool canPop = true, int? delayInSeconds}) {
  void action() {
    if (canPop) {
      Navigator.push(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (_) => page),
      );
    } else {
      Navigator.pushAndRemoveUntil(
        navigatorKey.currentContext!,
        MaterialPageRoute(builder: (_) => page),
            (route) => false,
      );
    }
  }

  if (delayInSeconds != null) {
    Timer(Duration(seconds: delayInSeconds), action);
  } else {
    action();
  }
}


void showMasg(String msg){
  if(msg.isNotEmpty ){
    ScaffoldMessenger.of(navigatorKey.currentContext!,).
    showSnackBar(
        SnackBar(
          content:
          Text(msg),
          duration:  Duration(seconds: 2),
          // Text('الرجاء تفعيل خدمه الوصول الي الموقع')
        ));

  }


}
