import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';
import '../../core/ui/image_picker.dart';
import '../auth/change_password.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24).r,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              ProfileImagePicker(icon: 'edit.svg'),
              SizedBox(height: 34.h),
              AppInput(hint: 'Entter Your name'),
              AppInput(hint: 'Entter Your Phone'),
              AppInput(hint: 'Enter your age', withType: true),
              SizedBox(height: 33.w),
              AppButtom(text: 'Save', onPressed: () {}),
              SizedBox(height: 21.h),
              InkWell(
                onTap: () {
                  goTo(ChangePasswordView(), canPop: true);
                },
                child: ListTile(
                  leading: Text(
                    'Change Password',
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 16.sp,
                      color: Colors.black,
                    ),
                  ),
                  trailing: AppImage(image: 'edit.svg', color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
