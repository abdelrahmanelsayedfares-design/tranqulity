import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';
import 'package:tranqulity/views/auth/login.dart';
import 'package:tranqulity/views/home/view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            vertical: 94,
            horizontal: 24,
          ).copyWith(bottom: 0).r,
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 153.w,
                      height: 153.h,
                      alignment: AlignmentDirectional.center,
                      decoration: BoxDecoration(
                        color: const Color(0xff000000).withOpacity(.10),
                        shape: BoxShape.circle,
                      ),
                      child: AppImage(
                        image: 'not_image.png',
                        width: 54.5.w,
                        height: 54.5.h,
                      ),
                    ),
                    Positioned(
                      right: -5,
                      bottom: -5,
                      child: Container(
                        width: 51.2.w,
                        height: 51.2.h,
                        alignment: AlignmentDirectional.center,
                        decoration: const BoxDecoration(
                          color: Color(0xff284243),
                          shape: BoxShape.circle,
                        ),
                        child: AppImage(
                          image: 'plus.svg',
                          width: 21.w,
                          height: 21.h,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 41.h),
              AppInput(hint: 'Username'),
              AppInput(hint: 'Phone Number'),
              AppInput(hint: 'Age'),
              AppInput(hint: 'Gender', leading: true),
              AppInput(hint: 'Password', isbass: true),
              SizedBox(height: 26.h),
              TextButton(onPressed: () {}, child: Text('Confirm password ')),
              SizedBox(height: 45.h),
              AppButtom(text: 'Sign Up', onPressed: () {
                goTo(HomeView(),canPop: false);
              }),
              SizedBox(height: 36.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account ?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
                  ),
                  TextButton(
                    onPressed: () {
                      goTo(LoginView(),canPop: false);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Color(0xff284243),
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
