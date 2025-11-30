import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_images.dart';

import 'auth/login.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({super.key});

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final List = [
    _model(
      image: 'on_boarding1.png',
      text: 'Feel Free',
      desc:
          'Because Im the Friendly Chatbot\nHere To Assist You With Anything You\nNeed.',
    ),
    _model(
      image: 'on_boarding2.png',
      text: 'Ask For Anything',
      desc:
          'Im Your Friendly Neighborhood\nChatbot Ready To Assist You Wth\nAny Questions Or Concerns.',
    ),
    _model(
      image: 'on_boarding3.png',
      text: 'Your Secert is Save',
      desc: 'Our Platform Prioritizes Your Privacy\nAnd Security',
    ),
  ];
  int currentIndex = 0;

  void goToLogin(){
    goTo(LoginView(),canPop: false);

  }

  @override
  Widget build(BuildContext context) {
    bool islast = currentIndex == List.length - 1;
    final currentModel = List[currentIndex];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppImage(
                image: currentModel.image,
                height: 600.h,
                width: 430.w,
                fit: BoxFit.fill,
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.all(19.0),
                child: Text(
                  currentModel.text,
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 24.h),
              Padding(
                padding: const EdgeInsets.only(left: 19.0, right: 12),
                child: Text(
                  currentModel.desc,
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 95.h),
              Padding(
                padding: const EdgeInsets.all(19),
                child: Row(
                  children: [
                    islast
                        ? SizedBox()
                        : TextButton(
                            onPressed: () {
                              goToLogin();
                            },
                            child: Text(
                              'skip',
                              style: TextStyle(
                                color: Color(0xff000000),
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                    Spacer(),
                    InkWell(
                      onTap: () {
                        if(islast ){
                          goToLogin();
                        }else
                          currentIndex++;
                        setState(() {});
                      },
                      child: Container(
                        width: 60.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xff284243),
                        ),
                        child: AppImage(
                          image: 'arrow.svg',
                          width: 32.w,
                          height: 32.h,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _model {
  final String image;
  final String text;
  final String desc;

  _model({required this.image, required this.text, required this.desc});
}
