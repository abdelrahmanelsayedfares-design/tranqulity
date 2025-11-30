import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/views/auth/login.dart';
import 'app_images.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key, });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child:  Column(
        children: [
          Container(
            width: double.infinity,
            height: 286.h,
            decoration: BoxDecoration(
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
                  image:
                  'https://flex-home.botble.com/storage/accounts/8.jpg',
                  width: 160.w,
                  height: 160.h,
                ),
                SizedBox(height: 17.h),
                Text(
                  'Sara\n 01027545631',
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
          _Model(image: 'about_us.svg',text: 'About Us', onTap: (){},),
          _Model(image: 'star.svg',text: 'Rate Our App', onTap: (){},),
          _Model(image: 'suggestions.svg',text: 'Suggestions', onTap: (){},),
          _Model(image: 'enable.svg',text: 'Enable Easy Login',switchh: true, onTap: (){},),
          _Model(image: 'log_out.svg',text: 'Logout',color: true, onTap: (){
            goTo(LoginView(),canPop: false);
          },),
        ],
      ),
    );
  }
}

class _Model extends StatefulWidget {
  final String text,image;
  final bool color;
  final bool switchh;
  final void Function() onTap;
  const _Model({super.key, required this.text, required this.image, this.color=false, this.switchh=false, required this.onTap});

  @override
  State<_Model> createState() => _ModelState();
}

class _ModelState extends State<_Model> {

  bool status=true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16).copyWith(bottom: 0).r,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color:widget.color?Color(0xFFEF5350).withValues(alpha: .10): Color(0xFF2842431A).withValues(alpha: .10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: AppImage(image: widget.image,width: 24.w,height: 24.h,),
            title: Text(widget.text),
            trailing:widget.switchh? Switch(
              activeTrackColor: Color(0xff2F65F0),
              value: status, onChanged: (value) {
              setState(() {
                status=value;
              });
            },):null,
          ),
        ),
      ),
    );
  }
}
