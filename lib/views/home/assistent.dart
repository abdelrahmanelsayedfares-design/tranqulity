import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import 'new_chat.dart';

class AssistentView extends StatelessWidget {
  const AssistentView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff28424326).withValues(alpha: .15),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.4,
                color: Color(0xff28424326).withValues(alpha: .15),
                child: Column(
                  children: [
                    Center(child: AppImage(image: 'assistent.svg')),
                    SizedBox(height: 14.h),
                    Text(
                      'Hey!',
                      style: TextStyle(
                        fontSize: 50.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff284243),
                      ),
                    ),
                    SizedBox(height: 9.h),
                    Text(
                      'I’am your Personal Assistent',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff284243),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 22,
                  vertical: 48,
                ).copyWith(bottom: 0).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make New Chat',
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w500,
                        color: Color(0xff284243),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    AppInput(hint: 'Enter The Title Of Chat'),
                    SizedBox(height: 24.h),
                    AppButtom(
                      text: 'Start Chat',
                      onPressed: () {
                        goTo(NewChatView(), canPop: true);
                      },
                    ),
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
