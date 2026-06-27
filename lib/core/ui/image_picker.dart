import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class ProfileImagePicker extends StatefulWidget {
  final String icon;
  final String? imageUrl;
  final Function(File?) onChanged;

  const ProfileImagePicker({
    super.key,
    required this.icon,
    required this.onChanged,
    this.imageUrl,
  });

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ImagePicker picker = ImagePicker();
  File? selectedImage;

  Future<void> pickImage(ImageSource source) async {
    final image = await picker.pickImage(source: source);

    if (image != null) {
      final file = File(image.path);

      setState(() {
        selectedImage = file;
      });

      widget.onChanged(file);
    }
  }

  void removeImage() {
    setState(() {
      selectedImage = null;
    });

    widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),

        Center(
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[300],
                child: selectedImage != null
                    ? ClipOval(
                  child: Image.file(
                    selectedImage!,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                )
                    : (widget.imageUrl != null && widget.imageUrl!.isNotEmpty)
                    ? ClipOval(
                  child: Image.network(
                    widget.imageUrl!,
                    width: 140,
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                )
                    : AppImage(
                  image: 'not_image.png',
                  width: 50.w,
                  height: 50.h,
                ),
              ),

              CircleAvatar(
                radius: 22,
                backgroundColor: const Color(0xff284243),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (_) => SizedBox(
                        height: 160.h,
                        child: Column(
                          children: [
                            const SizedBox(height: 10),
                            const Text(
                              "Profile Image",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const Divider(),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _Action(
                                  icon: Icons.camera_alt,
                                  text: "Camera",
                                  onTap: () => pickImage(ImageSource.camera),
                                ),
                                _Action(
                                  icon: Icons.image,
                                  text: "Gallery",
                                  onTap: () => pickImage(ImageSource.gallery),
                                ),
                                if (selectedImage != null)
                                  _Action(
                                    icon: Icons.delete,
                                    text: "Remove",
                                    isRed: true,
                                    onTap: removeImage,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  icon: AppImage(
                    image: widget.icon,
                    width: 24.w,
                    height: 24.h,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _Action extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;
  final bool isRed;

  const _Action({
    required this.icon,
    required this.text,
    required this.onTap,
    this.isRed = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onTap,
          icon: Icon(icon),
          color: isRed ? Colors.red : Colors.black,
        ),
        Text(text),
      ],
    );
  }
}