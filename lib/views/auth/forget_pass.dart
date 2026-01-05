import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';
import 'package:tranqulity/views/auth/otp.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 25.r,
        ).copyWith(bottom: 0.r),
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(image: 'forget_password.png'),
            SizedBox(height: 23.49.h),
            Text('Forget Your Password',style: Theme.of(context).textTheme.bodySmall,),
            SizedBox(height: 33.h,),
            AppInput(hint: 'Phone Number'),
            SizedBox(height: 33.h,),
            AppButtom(text: 'Forget Password',onPressed: (){
              goTo(OtpView(),canPop: true);
            },),
          ],
        ),
      ),
    );
  }
}
