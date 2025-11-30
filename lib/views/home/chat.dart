import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(left: 23,top: 39,bottom: 16).r,
          physics: BouncingScrollPhysics(),
          child: Column(
            children: [
              _Model(text: 'About Work',trailing: '10/12/2021',),
              _Model(text: 'About My Family',trailing: '10/12/2021',),
              _Model(text: 'My self',trailing: '10/12/2021',),
            ],
          ),
        ),
      ),
    );
  }
}
class _Model extends StatelessWidget {
  final String text,trailing;

  const _Model({super.key, required this.text, required this.trailing});

  @override
  Widget build(BuildContext context) {
    return     Padding(
      padding: const EdgeInsets.only(bottom: 16).r,
      child: Row(
        children: [
          Container(
            width: 353.w,
            height: 59.h,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(9),
              color: Color(0xff2842431A).withValues(alpha: .10),
            ),
            child: ListTile(
              title: Text(text,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
              trailing: Text(trailing,),
            ),
          ),
          Expanded(child: AppImage(image: 'delete.svg')),
        ],
      ),
    );
  }
}
