import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_images.dart';

import 'new_chat.dart';

class ShowChatView extends StatefulWidget {
  const ShowChatView({super.key});

  @override
  State<ShowChatView> createState() => _ShowChatViewState();
}

class _ShowChatViewState extends State<ShowChatView> {
  List chats = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final resp = await DioHelper.getData('api/Chat');

    if (resp.isSuccess) {
      chats = resp.data ?? [];
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: getData,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(
              left: 23.w,
              top: 39.h,
              bottom: 16.h,
            ),
            itemCount: chats.length,
            itemBuilder: (context, index) {
              final item = chats[index];

              return _Model(
                text: item['title'] ?? '',
                trailing: item['id'].toString(),
                onTap: () {
                  goTo(
                    NewChatView(
                      chatId: int.parse(item['id'].toString()),
                      title: item['title'] ?? '',
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Model extends StatelessWidget {
  final String text, trailing;
  final VoidCallback onTap;

  const _Model({
    super.key,
    required this.text,
    required this.trailing,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16).r,
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Container(
              width: 353.w,
              height: 59.h,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(9),
                color: const Color(0xff2842431A).withValues(alpha: .10),
              ),
              child: ListTile(
                title: Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                trailing: Text(trailing),
              ),
            ),
            SizedBox(width: 10.w),
            InkWell(
              onTap: () {
                // deleteChat(trailing);

              },
              child: AppImage(image: 'delete.svg'),
            ),
          ],
        ),
      ),
    );
  }
}