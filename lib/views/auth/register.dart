import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_input.dart';
import 'package:tranqulity/core/ui/image_picker.dart';
import 'package:tranqulity/core/ui/type_male.dart';
import 'package:tranqulity/views/auth/login.dart';
import 'package:tranqulity/views/home/view.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24).r,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileImagePicker(icon: 'plus.svg'),
            SizedBox(height: 41.h),
            AppInput(hint: 'Username'),
            AppInput(hint: 'Phone Number'),
            AppInput(hint: 'Age'),
            TypeMale(
              width: 370.w,
              hint: Text(
                'Gender',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff000000),
                ),
              ),
              height: 12.h,
            ),
            SizedBox(height: 16.h),
            AppInput(hint: 'Password', isbass: true),
            SizedBox(height: 26.h),
            TextButton(onPressed: () {}, child: Text('Confirm password ')),
            SizedBox(height: 45.h),
            AppButtom(
              text: 'Sign Up',
              onPressed: () {
                goTo(HomeView(), canPop: false);
              },
            ),
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
                    goTo(LoginView(), canPop: false);
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
    );
  }
}
