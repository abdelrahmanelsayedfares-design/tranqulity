import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/logic/input_validator.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/views/auth/forget_pass.dart';
import 'package:tranqulity/views/auth/register.dart';
import 'package:tranqulity/views/home/view.dart';
import '../../core/logic/cash_helper.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/ui/app_buttom.dart';
import '../../core/ui/app_input.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formerly = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoginClicked = false;
  bool isLoading = false;
  DataState?state;

  Future<void> sentData() async {
    setState(() => isLoading = true);

    final resp = await DioHelper.sendData(
      'api/Auth/login',
      data: FormData.fromMap({
        'Email': emailController.text.trim(),
        'Password': passwordController.text.trim(),
        'DeviceToken': 'mock_device_token',
        'DeviceType': 'Android',
      }),
    );

    if (resp.isSuccess) {
      final user = UserData.fromJson(resp.data);

      await CacheHelper.saveUser(user: user.data);

      showMsg(resp.message!);

      goTo(HomeView(), canPop: false);
    } else {
      print(resp.message);
      showMsg(resp.message ?? 'Login failed!',isError: true);
    }

    setState(() => isLoading = false);
  }


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
          child: Form(
            key: formerly,
            onChanged: () {
              if (isLoginClicked) {
                formerly.currentState!.validate();
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppImage(image: 'login.png', width: 382.w, height: 180.h),
                SizedBox(height: 24.h),
                Text(
                  'Welcome To',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                SizedBox(height: 6.h),
                Text(
                  'Tranquility',
                  style: Theme.of(context).textTheme.labelMedium,
                ),
                SizedBox(height: 10.h),
                AppInput(
                  hint: 'Enter your Email',
                  textInputType: TextInputType.emailAddress,
                  validator: InputValidator.emailValidator,
                  controller: emailController,
                ),
                AppInput(
                  hint: 'Enter your password',
                  textInputType: TextInputType.text,
                  isbass: true,
                  controller: passwordController,
                  validator: InputValidator.passwordValidator,
                ),
                SizedBox(height: 24.h),
                Align(
                  alignment: AlignmentGeometry.centerRight,
                  child: TextButton(
                    onPressed: () {
                      goTo(ForgetPasswordView(), canPop: true);
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
                        text: isLoading ? 'Loading...' : 'Log In',
                        onPressed: isLoading
                            ? null
                            : () {
                          setState(() {
                            isLoginClicked = true;
                          });

                          if (formerly.currentState!.validate()) {
                            sentData();
                          }
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
                        goTo(RegisterView(), canPop: true);
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
// {
// "data": {
// "token": "eyJhbGciOiJodHRwOi8vd3d3LnczLm9yZy8yMDAxLzA0L3htbGRzaWctbW9yZSNobWFjLXNoYTUxMiIsInR5cCI6IkpXVCJ9.eyJodHRwOi8vc2NoZW1hcy54bWxzb2FwLm9yZy93cy8yMDA1LzA1L2lkZW50aXR5L2NsYWltcy9uYW1laWRlbnRpZmllciI6IjEyIiwiaHR0cDovL3NjaGVtYXMueG1sc29hcC5vcmcvd3MvMjAwNS8wNS9pZGVudGl0eS9jbGFpbXMvZW1haWxhZGRyZXNzIjoiYW1yYW1lcjUyMkBnbWFpbC5jb20iLCJodHRwOi8vc2NoZW1hcy5taWNyb3NvZnQuY29tL3dzLzIwMDgvMDYvaWRlbnRpdHkvY2xhaW1zL3JvbGUiOiJVc2VyIiwiZXhwIjoxNzc3Mzg4MzE1LCJpc3MiOiJUcmFucXVpbGl0eUFwaSIsImF1ZCI6IlRyYW5xdWlsaXR5VXNlcnMifQ.0HxkNCVn6a1nfyWYzLi7f4D4ZW98lE-lJztRsd_jGyrCuirbimM8AroFrCXoJX-lHj1PX-f9fLtUvJc_t26JXw",
// "id": 12,
// "email": "amramer522@gmail.com",
// "name": "Amr Amer",
// "imageUrl": "https://tranquility.growfet.com/uploads/324fc504-dea5-444e-beae-eef8d1057797_5771581085799091443.jpg",
// "age": 26,
// "gender": "Male",
// "isVerified": true,
// "isEasyLoginEnabled": false
// }
// }
class UserData {

  late final UserModel data;

  UserData.fromJson(Map<String, dynamic> json){
    data = UserModel.fromJson(json['data']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['data'] = data.toJson();
    return _data;
  }
}

class UserModel {
  final String token;
  final int id;
  final String email;
  final String name;
  final String imageUrl;
  final int age;
  final String gender;
  final bool isVerified;
  final bool isEasyLoginEnabled;

  UserModel({
    required this.token,
    required this.id,
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.age,
    required this.gender,
    required this.isVerified,
    required this.isEasyLoginEnabled,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      token: json['token'] ?? '',
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      name: json['name'] ?? '',
      imageUrl: json['imageUrl'] ?? '',
      age: json['age'] ?? 0,
      gender: json['gender'] ?? '',
      isVerified: json['isVerified'] ?? false,
      isEasyLoginEnabled: json['isEasyLoginEnabled'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'id': id,
      'email': email,
      'name': name,
      'imageUrl': imageUrl,
      'age': age,
      'gender': gender,
      'isVerified': isVerified,
      'isEasyLoginEnabled': isEasyLoginEnabled,
    };
  }
}