import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/drawer.dart';
import 'package:tranqulity/views/home/chat.dart';
import 'package:tranqulity/views/home/profile.dart';
import 'package:tranqulity/views/home/quotes.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final list = [
    _Model(title: 'Chats', text: 'Chats', image: 'chats.svg', page: ChatView()),
    _Model(
      title: 'Quotes',
      text: 'Quotes',
      image: 'amoon.svg',
      page: QuotesView(),
    ),
    _Model(
      title: 'Edit Profile',
      text: 'Profile',
      image: 'profile.svg',
      page: ProfileView(),
    ),
  ];
  int current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(
          list[current].title,
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      drawer:DrawerView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Color(0xff284243),
        child: AppImage(image: 'floating.svg', width: 24.w, height: 24.h),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          setState(() {
            current = value;
          });
        },
        backgroundColor: Color(0xff284243),
        currentIndex: current,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: List.generate(
          list.length,
          (index) => BottomNavigationBarItem(
            icon: AppImage(
              image: list[index].image,
              color: current == index ? Colors.white : null,
            ),
            label: list[index].text,
          ),
        ),
      ),
      body: list[current].page,
    );
  }
}

class _Model {
  final String text, image, title;
  final Widget page;

  _Model({
    required this.text,
    required this.image,
    required this.page,
    required this.title,
  });
}
