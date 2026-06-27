import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';
import 'package:tranqulity/core/ui/type_male.dart';

class AppInput extends StatefulWidget {
  final String? hint;
  final bool isbass;
  final bool withType;
  final bool message;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final DropdownController? dropdownController;
  final VoidCallback? onSend;

  const AppInput({
    super.key,
    this.hint,
    this.isbass = false,
    this.withType = false,
    this.message = false,
    this.validator,
    this.controller,
    required this.textInputType,
    this.dropdownController,
    this.onSend,
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
            child: SizedBox(
              height: 60.h,
              child: TextFormField(
                controller: widget.controller,
                validator: widget.validator,
                keyboardType: widget.textInputType,
                obscureText: widget.isbass ? _obscureText : false,
                decoration: InputDecoration(
                  hintText: widget.hint,

                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 18.h,
                  ),

                  suffixIcon: widget.isbass
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                          icon: _obscureText
                              ? Icon(Icons.visibility_off)
                              : Icon(Icons.visibility),
                        )
                      : null,
                ),
              ),
            ),
          ),

          if (widget.withType) ...[
            SizedBox(width: 12.w),
            Expanded(
              child: TypeMale(
                controller: widget.dropdownController ?? DropdownController(),
              ),
            ),
          ],

          if (widget.message) ...[
            SizedBox(width: 12.w),
            InkWell(
              onTap:widget.onSend,
              child: Container(
                width: 60.w,
                height: 60.h,
                decoration: BoxDecoration(
                  color: const Color(0xff284243),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: AppImage(image: 'send_message.svg'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
