import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_images.dart';


class DrawerItem extends StatefulWidget {
  final String text;
  final String image;
  final bool color;
  final bool switchh;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.text,
    required this.image,
    required this.onTap,
    this.color = false,
    this.switchh = false,
  });

  @override
  State<DrawerItem> createState() => _DrawerItemState();
}

class _DrawerItemState extends State<DrawerItem> {
  bool status = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ).copyWith(bottom: 0).r,
      child: InkWell(
        onTap: widget.onTap,
        child: Container(
          decoration: BoxDecoration(
            color: widget.color
                ? const Color(0xFFEF5350).withValues(alpha: .10)
                : const Color(0xFF2842431A).withValues(alpha: .10),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
            leading: AppImage(
              image: widget.image,
              width: 24.w,
              height: 24.h,
            ),
            title: Text(widget.text),
            trailing: widget.switchh
                ? Switch(
              activeTrackColor: const Color(0xff2F65F0),
              value: status,
              onChanged: (value) {
                setState(() {
                  status = value;
                });
              },
            )
                : null,
          ),
        ),
      ),
    );
  }
}