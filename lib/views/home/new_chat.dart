import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/app_input.dart';

class NewChatView extends StatefulWidget {
  final int chatId;
  final String title;

  const NewChatView({
    super.key,
    required this.chatId,
    required this.title,
  });

  @override
  State<NewChatView> createState() => _NewChatViewState();
}

class _NewChatViewState extends State<NewChatView> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();

  List messages = [];

  bool isLoading = true;
  bool isSending = false;

  @override
  void initState() {
    super.initState();
    getMessages();
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  // ================= GET MESSAGES =================
  Future<void> getMessages() async {
    setState(() => isLoading = true);

    final resp = await DioHelper.getData(
      'api/Chat/${widget.chatId}/messages',
    );

    if (resp.isSuccess) {
      messages = resp.data ?? [];
    }

    setState(() => isLoading = false);

    scrollToBottom();
  }

  // ================= SCROLL =================
  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 200), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  // ================= SEND MESSAGE =================
  Future<void> sendMessage() async {
    if (messageController.text.trim().isEmpty) return;

    setState(() => isSending = true);

    final text = messageController.text;
    messageController.clear();

    final resp = await DioHelper.sendData(
      'api/Chat/${widget.chatId}/messages',
      data: {
        "Text": text,
      },
    );

    if (resp.isSuccess) {
      await getMessages();
    }

    setState(() => isSending = false);
  }

  // ================= MESSAGE UI =================
  Widget buildMessageItem(Map item) {
    final bool isUser = item['isUserMessage'] == true;
    final String text = item['text'] ?? '';

    return Align(
      alignment:
      isUser
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: isUser
          ? Container(
        margin: EdgeInsets.only(bottom: 14.h),
        padding: EdgeInsets.all(12.r),
        constraints: BoxConstraints(maxWidth: 260.w),
        decoration: BoxDecoration(
          color: const Color(0xff284243),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
          ),
        ),
      )
          : Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppImage(
            image: 'robot.png',
            isCircle: true,
            width: 36.w,
            height: 36.h,
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(bottom: 14.h),
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                text,
                style: TextStyle(fontSize: 16.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= UI =================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),

      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: messages.isEmpty
                ? Center(
              child: Text(
                "No messages yet",
                style: TextStyle(fontSize: 16.sp),
              ),
            )
                : ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(14.r),
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return buildMessageItem(messages[index]);
              },
            ),
          ),

          if (isSending)
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: const CircularProgressIndicator(),
            ),
        ],
      ),

      // ================= INPUT =================
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(14.r),
            child: Row(
              children: [
                Expanded(
                  child: AppInput(
                    controller: messageController,
                    hint: 'Write your message',
                    textInputType: TextInputType.text,
                    message: true,
                    onSend: sendMessage,
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