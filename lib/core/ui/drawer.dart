import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/cash_helper.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/model_drawer.dart';

import '../logic/dio_helper.dart';
import '../logic/helper_methods.dart';

class DrawerView extends StatefulWidget {
  const DrawerView({super.key});

  @override
  State<DrawerView> createState() => _DrawerViewState();
}

class _DrawerViewState extends State<DrawerView> {

  Future<void> logout() async {
    final resp = await DioHelper.sendData(
      'api/Profile/logout',
    );

    if (resp.isSuccess) {
      await CacheHelper.logout();
    } else {
      showMsg(
        resp.message ?? 'Logout failed',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 286.h,
            decoration: const BoxDecoration(
              color: Color(0xff284243),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AppImage(
                  isCircle: true,
                  image: CacheHelper.image,
                  width: 100.w,
                  height: 100.h,
                ),
                SizedBox(height: 17.h),
                Text(
                  '${CacheHelper.name}\n${CacheHelper.email}',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          DrawerItem(
            image: 'about_us.svg',
            text: 'About Us',
            onTap: () {},
          ),

          DrawerItem(
            image: 'star.svg',
            text: 'Rate Our App',
            onTap: () {},
          ),

          DrawerItem(
            image: 'suggestions.svg',
            text: 'Suggestions',
            onTap: () {},
          ),

          DrawerItem(
            image: 'enable.svg',
            text: 'Enable Easy Login',
            switchh: true,
            onTap: () {},
          ),

          DrawerItem(
            image: 'log_out.svg',
            text: 'Logout',
            color: true,
            onTap: ()async{
             await logout();
            }
          ),
        ],
      ),
    );
  }
}