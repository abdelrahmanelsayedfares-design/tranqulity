import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/views/auth/change_pass.dart';

class OtpView extends StatelessWidget {
  const OtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 24.r,
            vertical: 52.r,
          ).copyWith(bottom: 0.r),
          physics: BouncingScrollPhysics(),
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
                'Please enter the code sent on your\n phone',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff284243AB).withValues(alpha: .67),
                ),
              ),
              SizedBox(height: 36.h),
              PinCodeTextField(
                length: 4,
                appContext: context,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                cursorColor: const Color(0xffD75D72),
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                enableActiveFill: true,
                // backgroundColor: Color(0xff28424308).withValues(alpha: 0.3),
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(8),
                  borderWidth: 1,
                  fieldHeight: 60.h,
                  fieldWidth: 83.5.w,
                  selectedFillColor: Colors.transparent,
                  inactiveColor: Color(0xff2842434A).withValues(alpha: .29),
                  // activeColor: Colors.brown,
                  disabledColor: Colors.green,
                  activeFillColor: Colors.red,
                  activeColor: Colors.transparent,
                  inactiveFillColor:Color(0xffACACAC1A).withValues(alpha: .10),
                  errorBorderColor: Colors.red,
                  selectedColor: Colors.blue,
                ),
              ),
              SizedBox(height: 60.h,),
              AppButtom(text: 'Verify',onPressed: (){
                goTo(ChangePasswordView(),canPop: true);
              },),
            ],
          ),
        ),
      ),
    );
  }
}
