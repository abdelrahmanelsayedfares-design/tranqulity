import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/views/auth/register.dart';
import 'package:tranqulity/views/home/view.dart';
import 'package:tranqulity/views/splach.dart';
import 'core/logic/helper_methods.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xff284243),
                minimumSize: Size(382.w, 60.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ),
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                foregroundColor: Colors.black,
                textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff000000),
              ),
              filled: true,
              fillColor: Color(0xff28424308).withValues(alpha: .03),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff2842434a).withValues(alpha: .29),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: Color(0xff2842434A).withValues(alpha: .29),
                ),
              ),
            ),
            textTheme: TextTheme(
              bodySmall: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              bodyMedium: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              labelMedium: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff284243),
                fontFamily: 'Mystery Quest',
              ),
              titleMedium: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            appBarTheme: AppBarTheme(
              backgroundColor: Color(0xffFFFFFF),
              scrolledUnderElevation: 0,
            ),
            scaffoldBackgroundColor: Color(0xffFFFFFF),
            fontFamily: 'Inter',
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: HomeView(),
        );
      },
    );
  }
}
