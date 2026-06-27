import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/logic/dio_helper.dart';
import 'package:tranqulity/core/logic/helper_methods.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class QuotesView extends StatefulWidget {
  const QuotesView({super.key});

  @override
  State<QuotesView> createState() => _QuotesViewState();
}

class _QuotesViewState extends State<QuotesView> {
  List quotes = [];
  bool isLoading = true;

  PageController controller = PageController();

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final resp = await DioHelper.getData('api/Quotes');

    if (resp.isSuccess) {
      quotes = resp.data ?? [];
    }

    setState(() => isLoading = false);
  }

  void copyText(String text) {
    Clipboard.setData(ClipboardData(text: text));
    showMsg("تم نسخ الاقتباس");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : quotes.isEmpty
            ? const Center(child: Text("No Quotes Available"))
            : PageView.builder(
          controller: controller,
          itemCount: quotes.length,
          itemBuilder: (context, index) {
            final item = quotes[index];

            return Stack(
              children: [
                // background image
                Positioned.fill(
                  child: AppImage(image: 'quotes .png'),
                ),

                // card
                Positioned(
                  right: 14.r,
                  top: 200.r,
                  child: Container(
                    width: 350.w,
                    height: 360.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 30,
                      ),
                      child: Column(
                        children: [
                          AppImage(image: 'quotes.svg'),

                          SizedBox(height: 20.h),

                          Text(
                            item['body'] ?? '',
                            style: TextStyle(
                              fontSize: 26.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xff284243),
                            ),
                            textAlign: TextAlign.center,
                          ),

                          SizedBox(height: 20.h),

                          Align(
                            alignment: AlignmentDirectional.centerEnd,
                            child: Text(
                              "- ${item['author'] ?? ''}",
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),

                          const Spacer(),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Copy',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xff284243),
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  copyText(
                                    "${item['body']}\n- ${item['author']}",
                                  );
                                },
                                icon: AppImage(image: 'copy.svg'),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}