import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class AppInput extends StatefulWidget {
  final String hint;
  final bool isbass;
  final bool leading;

  const AppInput({super.key, required this.hint, this.isbass = false,this.leading=false});

  @override
  State<AppInput> createState() => _AppInputState();
}

class _AppInputState extends State<AppInput> {
  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16).r,
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
              : widget.leading?AppImage(image: 'down.svg'):null,
        ),
      ),
    );
  }
}
