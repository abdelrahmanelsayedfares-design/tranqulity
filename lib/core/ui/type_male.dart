import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class DropdownController {
  String? value;

  DropdownController({this.value});

  void clear() {
    value = null;
  }
}

class TypeMale extends StatefulWidget {
  final double? width;
  final double? height;
  final Widget? hint;
  final DropdownController controller;
  final String? Function(String?)? validator;

  const TypeMale({
    super.key,
    this.width,
    this.height,
    this.hint,
    required this.controller,
    this.validator,
  });

  @override
  State<TypeMale> createState() => _TypeMaleState();
}

class _TypeMaleState extends State<TypeMale> {
  final List<String> item = ['Female', 'Male'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: widget.width,
      child: DropdownButtonFormField<String>(
        value: widget.controller.value,
        decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xff28424308).withValues(alpha: .03),
          contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: const Color(0xff28424308).withValues(alpha: .29),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Color(0xff284243)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: Colors.red),
          ),
        ),
        hint: widget.hint,
        icon: AppImage(
          image: 'down.svg',
          width: 12.w,
          height: widget.height,
        ),
        dropdownColor: Colors.white,
        isExpanded: true,
        validator: widget.validator,
        items: item.map((e) {
          return DropdownMenuItem<String>(
            value: e,
            child: Text(
              e,
              style: const TextStyle(
                color: Color(0xff434C6D),
              ),
            ),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            widget.controller.value = value;
          });
        },
      ),
    );
  }
}