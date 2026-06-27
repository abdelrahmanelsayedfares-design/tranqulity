import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/logic/input_validator.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';

import 'package:tranqulity/views/auth/login.dart';
import 'package:tranqulity/views/auth/creat_new_password.dart';

enum OtpType { register, forgetPassword }

class OtpView extends StatefulWidget {
  final String email;
  final OtpType type;

  const OtpView({super.key, required this.email, required this.type});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  final formerly = GlobalKey<FormState>();
  final otpController = TextEditingController();

  bool isLoginClicked = false;
  bool isLoading = false;

  Future<void> sentData() async {
    setState(() => isLoading = true);

    final otp = otpController.text.trim();

    final resp = await DioHelper.sendData(
      'api/Auth/verify-otp',
      isFormData: true,
      data: FormData.fromMap({
        'Email': widget.email,
        'Otp': otp,
        'DeviceToken': 'mock_device_token',
        'DeviceType': 'Android',
      }),
    );

    setState(() => isLoading = false);

    if (resp.isSuccess) {
      showMsg(resp.message!);

      if (widget.type == OtpType.register) {
        goTo(LoginView(), canPop: false);
      } else {
        goTo(CreatNewPasswordView(email: widget.email), canPop: false);
      }
    } else {
      showMsg(resp.message ?? 'Invalid OTP');
    }
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 52.h,
        ).copyWith(bottom: 0),

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
              AppImage(image: 'otp.png'),

              SizedBox(height: 24.h),

              Text(
                'Verification',
                style: Theme.of(context).textTheme.bodySmall,
              ),

              SizedBox(height: 8.h),

              Text(
                'Please enter the code sent to your email',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xff284243).withValues(alpha: .67),
                ),
              ),

              SizedBox(height: 36.h),

              PinCodeTextField(
                backgroundColor: Colors.transparent,
                controller: otpController,
                validator: InputValidator.verifyValidator,
                length: 4,
                appContext: context,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                cursorColor: const Color(0xffD75D72),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                enableActiveFill: true,

                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  borderWidth: 1,
                  fieldHeight: 60.h,
                  fieldWidth: 83.5.w,

                  selectedFillColor: Colors.transparent,
                  inactiveColor: const Color(
                    0xff2842434A,
                  ).withValues(alpha: .29),
                  disabledColor: Colors.green,
                  activeFillColor: Colors.transparent,
                  activeColor: Colors.transparent,
                  inactiveFillColor: const Color(
                    0xffACACAC1A,
                  ).withValues(alpha: .10),
                  errorBorderColor: Colors.red,
                  selectedColor: Colors.blue,
                ),
              ),

              SizedBox(height: 60.h),

              AppButtom(
                text: isLoading ? 'Loading...' : 'Verify',
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
