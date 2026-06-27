import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import '../../core/ui/app_images.dart';

class ChangePasswordView extends StatelessWidget {
  const ChangePasswordView({super.key});

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
            AppImage(image: 'chanegd_password.png'),
            SizedBox(height: 23.h),
            Text(
              'Change Your Password',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 24.h),
            AppInput(hint: 'Old Password',isbass: true,textInputType: TextInputType.text,),
            AppInput(hint: 'New Password',isbass: true,textInputType: TextInputType.text),
            AppInput(hint: 'Confirm New Password',isbass: true,textInputType: TextInputType.text),
            SizedBox(height: 36.h),
            AppButtom(text: 'Change Password',onPressed: (){},),

          ],
        ),
      ),
    );
  }
}
