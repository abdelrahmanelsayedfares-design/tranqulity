import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class TypeMale extends StatefulWidget {
  final double? width;
  final double? height;
  final Widget? hint;

  const TypeMale({super.key, this.width, this.hint, this.height});

  @override
  State<TypeMale> createState() => _TypeMaleState();
}

class _TypeMaleState extends State<TypeMale> {
  List<String> item = ['Female', 'Male'];
  String? selectedGender;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      width: widget.width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Color(0xff28424308).withValues(alpha: .03),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Color(0xff28424308).withValues(alpha: .29)),
        ),
        child: DropdownButton<String>(
          isExpanded: true,
          padding: EdgeInsets.all(8),
          hint: widget.hint,
          dropdownColor: Color(0xffFFFFFF),
          icon: AppImage(image: 'down.svg', width: 12.w, height: widget.height),
          value: selectedGender,
          items: item.map((e) {
            return DropdownMenuItem<String>(
              value: e,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(e, style: TextStyle(color: Color(0xff434C6D))),
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              selectedGender = value;
            });
          },
        ),
      ),
    );
  }
}
