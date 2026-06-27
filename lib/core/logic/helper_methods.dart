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


void showMsg(
    String msg, {
      bool isError = false,
    }) {
  final context = navigatorKey.currentContext;

  if (context == null || msg.isEmpty) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 2),
      backgroundColor: isError ? Colors.red : Colors.green,
      behavior: SnackBarBehavior.floating,
    ),
  );
}
