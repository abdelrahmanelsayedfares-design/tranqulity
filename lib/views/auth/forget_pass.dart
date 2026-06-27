import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/dio_helper.dart';

import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/logic/input_validator.dart';

import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import 'package:tranqulity/views/auth/otp.dart';

class ForgetPasswordView extends StatefulWidget {
  ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final formerly = GlobalKey<FormState>();

  final emailController = TextEditingController();

  bool isLoginClicked = false;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sentData() async {
    final resp = await DioHelper.sendData(
      'api/Auth/forgot-password',
      data: FormData.fromMap({'Email': emailController.text.trim()}),
    );
    if (resp.isSuccess) {
      showMsg(resp.message!);

      goTo(
        OtpView(
          email: emailController.text.trim(),
          type: OtpType.forgetPassword,
        ),
        canPop: true,
      );
    } else {
      showMsg(resp.message ?? 'Error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 25,
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
              AppImage(image: 'forget_password.png'),
              SizedBox(height: 23.49.h),
              Text(
                'Forget Your Password',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              SizedBox(height: 33.h),
              AppInput(
                hint: 'Email',
                controller: emailController,
                textInputType: TextInputType.emailAddress,
                validator: InputValidator.emailValidator,
              ),
              SizedBox(height: 33.h),
              AppButtom(
                text: 'Forget Password',
                onPressed: () {
                  setState(() {
                    isLoginClicked = true;
                  });

                  if (formerly.currentState!.validate()) {
                    sentData();
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
