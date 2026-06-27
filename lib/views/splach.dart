import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/cash_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/views/home/view.dart';
import 'package:tranqulity/views/on_boarding.dart';

import '../core/ui/app_images.dart';
import 'auth/login.dart';

class SplachView extends StatefulWidget {
  const SplachView({super.key});

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  @override
  void initState() {
    super.initState();
    goTo(
      CacheHelper.isFirstTime
          ? OnBoardingView()
          : CacheHelper.isAuth
          ? HomeView()
          : LoginView(),
      canPop: false,
      delayInSeconds: 3,
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 360.w,
          height: 360.h,
          decoration: BoxDecoration(
            color: Color(0xff284243).withValues(alpha: .30),
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 130).r,
            child: Column(
              children: [
                Text(
                  'Tranquility',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: 1.h),
                Text(
                  'Together Towards Tranquility',
                  style: TextStyle(
                    color: Color(0xff284243),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
