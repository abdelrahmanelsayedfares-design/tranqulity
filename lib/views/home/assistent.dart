import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/logic/input_validator.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import 'new_chat.dart';

class AssistentView extends StatefulWidget {
  const AssistentView({super.key});

  @override
  State<AssistentView> createState() => _AssistentViewState();
}

class _AssistentViewState extends State<AssistentView> {
  final formKey = GlobalKey<FormState>();
  final chatController = TextEditingController();
  bool isLoading = false;

  Future<void> sendData() async {
    setState(() => isLoading = true);

    final resp = await DioHelper.sendData(
      'api/Chat',
      data: FormData.fromMap({
        'Title': chatController.text,
      }),
    );

    setState(() => isLoading = false);

    if (resp.isSuccess) {
      final data = resp.data;

      goTo(
        NewChatView(
          chatId: data['id'],
          title: data['title'],
        ),
        canPop: true,
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff28424326).withValues(alpha: .15),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Form(
            key: formKey,
            onChanged: () {
              if (isLoading) {
                formKey.currentState!.validate();
              }
            },
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
                      AppInput(
                        hint: 'Enter The Title Of Chat',
                        textInputType: TextInputType.text,
                        controller: chatController,
                        validator: InputValidator.chatValidator,
                      ),
                      SizedBox(height: 24.h),
                      AppButtom(
                        text: isLoading ? 'Loading...' : 'Start Chat',
                        onPressed: isLoading
                            ? null
                            : () async {
                                if (formKey.currentState!.validate()) {
                                  await sendData();
                                }
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
