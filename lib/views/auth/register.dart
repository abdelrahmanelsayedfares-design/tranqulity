import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/logic/input_validator.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_input.dart';
import 'package:tranqulity/core/ui/image_picker.dart';
import 'package:tranqulity/core/ui/type_male.dart';
import 'package:tranqulity/views/auth/login.dart';
import 'otp.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formerly = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final genderController = DropdownController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  bool isLoginClicked = false;
  bool isLoading = false;
  File? selectedImage;

  Future<void> sentData() async {
    setState(() => isLoading = true);

    final resp = await DioHelper.sendData(
      'api/Auth/register',
      isFormData: true,
      data: FormData.fromMap({
        'Email': emailController.text.trim(),
        'Name': nameController.text.trim(),
        'Age': ageController.text.trim(),
        'Password': passwordController.text.trim(),
        'ConfirmPassword': confirmpasswordController.text.trim(),
        'Gender': genderController.value.toString(),
        'Image': selectedImage == null
            ? null
            : await MultipartFile.fromFile(
                selectedImage!.path,
                filename: selectedImage!.path.split('/').last,
              ),
      }),
    );
    if (resp.isSuccess) {
      showMsg(resp.message!);
      goTo(
        OtpView(email: emailController.text.trim(), type: OtpType.register),
        canPop: true,
      );
    } else {
      showMsg(resp.message ?? 'Register failed');
    }
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24).r,
        physics: BouncingScrollPhysics(),
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
              ProfileImagePicker(
                icon: 'plus.svg',
                onChanged: (file) {
                  setState(() {
                    selectedImage = file;
                  });
                },
              ),
              SizedBox(height: 41.h),
              AppInput(
                hint: 'Username',
                textInputType: TextInputType.name,
                controller: nameController,
                validator: InputValidator.nameValidator,
              ),
              AppInput(
                hint: 'Email',
                textInputType: TextInputType.emailAddress,
                controller: emailController,
                validator: InputValidator.emailValidator,
              ),
              AppInput(
                hint: 'Age',
                textInputType: TextInputType.number,
                controller: ageController,
                validator: InputValidator.ageValidator,
              ),
              TypeMale(
                controller: genderController,
                validator: InputValidator.genderValidator,
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
              AppInput(
                hint: 'Password',
                isbass: true,
                textInputType: TextInputType.text,
                controller: passwordController,
                validator: InputValidator.passwordValidator,
              ),
              AppInput(
                hint: 'Confirm Password',
                isbass: true,
                textInputType: TextInputType.text,
                controller: confirmpasswordController,
                validator: InputValidator.passwordValidator,
              ),
              SizedBox(height: 26.h),
              TextButton(onPressed: () {}, child: Text('Confirm password ')),
              SizedBox(height: 45.h),
              AppButtom(
                // text: 'Sign Up',
                text: isLoading ? 'Loading...' : 'Sign Up',
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
      ),
    );
  }
}
