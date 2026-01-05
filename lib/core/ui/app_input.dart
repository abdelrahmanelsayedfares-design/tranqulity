import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/type_male.dart';

class AppInput extends StatefulWidget {
  final String? hint;
  final bool isbass;
  final bool withType;
  final bool message;

  const AppInput({
    super.key,
    this.hint,
    this.isbass = false,
    this.withType = false,
    this.message = false,
  });

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16).r,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: TextFormField(
              obscureText: widget.isbass ? _obscureText : false,
              decoration: InputDecoration(
                hintText: widget.hint,
                suffixIcon: widget.isbass
                    ? IconButton(
                        onPressed: () {
                          _obscureText = !_obscureText;
                          setState(() {});
                        },
                        icon: _obscureText
                            ? Icon(Icons.visibility_off)
                            : Icon(Icons.visibility),
                        color: Colors.black,
                      )
                    : null,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          if (widget.withType) Expanded(child: TypeMale()),
          if (widget.message)
            InkWell(
              onTap: () {},
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: Color(0xff284243),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AppImage(image: 'send_message.svg'),
              ),
            ),
        ],
      ),
    );
  }
}
