import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/views/auth/forget_pass.dart';
import 'package:tranqulity/views/auth/register.dart';
import 'package:tranqulity/views/home/view.dart';

import '../../core/ui/app_buttom.dart';
import '../../core/ui/app_input.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 52,
          ).copyWith(bottom: 0).r,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppImage(image: 'login.png', width: 382.w, height: 180.h),
              SizedBox(height: 24.h),
              Text('Welcome To', style: Theme.of(context).textTheme.bodyMedium),
              SizedBox(height: 6.h),
              Text(
                'Tranquility',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              SizedBox(height: 10.h),
              AppInput(hint: 'Enter your phone'),
              AppInput(hint: 'Enter your password', isbass: true),
              SizedBox(height: 24.h),
              Align(
                alignment: AlignmentGeometry.centerRight,
                child: TextButton(
                  onPressed: () {
                    goTo(ForgetPasswordView(),canPop: true);
                  },
                  child: Text(
                    'Forget Password?',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff284243),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 56.h),
              Row(
                children: [
                  Container(
                    width: 56.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Color(0xff2842431A).withValues(alpha: .10),
                    ),
                    child: AppImage(
                      image: 'enable.svg',
                      width: 24.w,
                      height: 30.h,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: AppButtom(
                      text: 'Log In',
                      onPressed: () {
                        goTo(HomeView(), canPop: true);
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Don’t have an account ?'),
                  SizedBox(width: 8.w),
                  TextButton(
                    onPressed: () {
                      goTo(RegisterView(),canPop: true);
                    },
                    child: Text(
                      'Sign up',
                      style: TextStyle(color: Color(0xff284243)),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              _LoginAccount(
                image: 'google.png',
                text: 'Login With Google',
                color: Color(0xff35B54280),
              ),
              SizedBox(height: 16.h),
              _LoginAccount(
                image: 'facebook.png',
                text: 'Login With Facebook',
                color: Color(0xff518EF880),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginAccount extends StatelessWidget {
  final String text;
  final String image;
  final Color color;
  const _LoginAccount({
    super.key,
    required this.text,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 382,
      height: 51,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 51,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xff2842434D).withValues(alpha: .30),
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: AppImage(image: image, width: 24.w, height: 24.h),
              ),
            ),
            Container(
              width: 326.w,
              height: 51,
              color: color.withValues(alpha: .50),
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
