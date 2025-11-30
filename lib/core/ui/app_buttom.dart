import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtom extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const AppButtom({super.key, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text, style: TextStyle(fontSize:18.sp,color: Colors.white)),
    );
  }
}
