import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';
import 'package:tranqulity/views/home/view.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 52,
            horizontal: 24,
          ).copyWith(bottom: 0).r,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(image: 'chanegd_password.png'),
              SizedBox(height: 23.49.h),
              Text(
                'Create New Password',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 16.h),
              Text(
                'create your new password to log in !',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 18.h),
              AppInput(hint: 'password', isbass: true),
              AppInput(hint: 'Confirm Password', isbass: true),
              SizedBox(height: 62.h),
              AppButtom(
                text: 'Confirm',
                onPressed: () {
                  goTo(HomeView(), canPop: false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
