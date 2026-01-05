import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import '../../core/ui/app_buttom.dart';

class NewChatView extends StatelessWidget {
  const NewChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'About Work',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500),
          ),
        ),
        actions: [
          PopupMenuButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            color: Colors.white,
            icon: AppImage(image: 'menu.svg'),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: Text(
                              'Edit Title',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.close, color: Colors.red),
                            ),
                          ),
                          SizedBox(height: 35.h),
                          AppInput(),
                          SizedBox(height: 21.h),
                          AppButtom(text: 'save', onPressed: () {}),
                        ],
                      ),
                    ),
                  );
                },
                value: 1,
                child: Row(
                  children: [
                    AppImage(image: 'edit_title.svg'),
                    SizedBox(width: 16.w),
                    Text('Profile'),
                  ],
                ),
              ),
              PopupMenuItem(
                onTap: () {},
                value: 2,
                child: Row(
                  children: [
                    AppImage(image: 'delete.svg'),
                    SizedBox(width: 16.w),
                    Text('Delete Chat', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 1) {
                // go to profile
              } else if (value == 2) {
                // logout
              }
            },
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(14).r,
        child: AppInput(hint: 'write your message', message: true),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 11,
          vertical: 250,
        ).copyWith(bottom: 0).r,
        child: Column(
          children: [
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 198.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: Color(0xff284243),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'Hello How are you?',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _Model(
              text:
                  'Hello! Im just a computer program,so I dont have feelings in the same way humans do, but Im here and ready to assist you. How can I help you today?',
            ),
            SizedBox(height: 16.h),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 198.w,
                height: 42.h,
                decoration: BoxDecoration(
                  color: Color(0xff284243),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    'I feel upset',
                    style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            _Model(
              text:
                  'Im sorry to hear that youre feeling upset. If youd like, you can share whats on your mind, and Im here to listen and offer support or guidance if you need it. Remember, its okay to feel upset sometimes, and its important to take care of yourself.',
            ),
          ],
        ),
      ),
    );
  }
}

class _Model extends StatelessWidget {
  final String text;

  const _Model({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppImage(image: 'robot.png', isCircle: true, width: 36.w, height: 36.h),
        SizedBox(width: 7.w),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Color(0xff2842431A).withValues(alpha: .10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(text, style: Theme.of(context).textTheme.titleMedium),
            ),
          ),
        ),
      ],
    );
  }
}
