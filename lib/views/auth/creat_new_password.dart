import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/logic/input_validator.dart';

import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import 'package:tranqulity/views/auth/login.dart';

class CreatNewPasswordView extends StatefulWidget {
  final String email;

  const CreatNewPasswordView({super.key, required this.email});

  @override
  State<CreatNewPasswordView> createState() => _CreateNewPasswordViewState();
}

class _CreateNewPasswordViewState extends State<CreatNewPasswordView> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final formerly = GlobalKey<FormState>();

  bool isLoginClicked = false;
  bool isLoading = false;

  Future<void> sentData() async {
    if (passwordController.text.trim() !=
        confirmPasswordController.text.trim()) {
      showMsg('Passwords do not match');
      return;
    }

    setState(() => isLoading = true);

    final resp = await DioHelper.sendData(
      'api/Auth/reset-password',
      data: FormData.fromMap({
        'NewPassword': passwordController.text.trim(),
        'ConfirmNewPassword': confirmPasswordController.text.trim(),
      }),
    );

    setState(() => isLoading = false);

    if (resp.isSuccess) {
      showMsg(resp.message!);

      goTo(LoginView(), canPop: false);
    } else {
      showMsg(resp.message ?? 'Failed to reset password');
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          vertical: 52,
          horizontal: 24,
        ).copyWith(bottom: 0).r,

        physics: const BouncingScrollPhysics(),

        child: Form(
          key: formerly,

          onChanged: () {
            if (isLoginClicked) {
              formerly.currentState!.validate();
            }
          },

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
                'Create your new password to log in!',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 18.h),

              AppInput(
                controller: passwordController,
                validator: InputValidator.passwordValidator,
                hint: 'Password',
                isbass: true,
                textInputType: TextInputType.text,
              ),

              AppInput(
                controller: confirmPasswordController,
                validator: InputValidator.passwordValidator,
                hint: 'Confirm Password',
                isbass: true,
                textInputType: TextInputType.text,
              ),

              SizedBox(height: 62.h),

              AppButtom(
                text: isLoading ? 'Loading...' : 'Confirm',

                onPressed: isLoading
                    ? null
                    : () async {
                        setState(() {
                          isLoginClicked = true;
                        });

                        if (formerly.currentState!.validate()) {
                          await sentData();
                        }
                      },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
