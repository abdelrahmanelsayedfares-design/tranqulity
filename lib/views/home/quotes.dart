import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class QuotesView extends StatelessWidget {
  const QuotesView({super.key});
  final String quote =
      '“ The only way to do great work is to love what you do “';
  final String author = 'Steve Jobs';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              Stack(
                children: [
                  AppImage(image: 'quotes .png'),
                  Positioned(
                    right: 14.r,
                    top: 215.r,
                    child: Container(
                      width: 403.w,
                      height: 358.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 36,
                        ).copyWith(bottom: 0),
                        child: Column(
                          children: [
                            AppImage(image: 'quotes.svg'),
                            Text(
                              quote,
                              style: TextStyle(
                                fontSize: 34.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff284243),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 16.h),
                            Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Text(
                                author,
                                style: TextStyle(
                                  fontSize: 34.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Copy',
                                    style: TextStyle(
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xff284243),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      Clipboard.setData(
                                        ClipboardData(
                                          text: '$quote\n— $author',
                                        ),
                                      );
                                      showMasg('تم عمليه النسخ');
                                    },
                                    icon: AppImage(image: 'copy.svg'),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
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
