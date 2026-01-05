import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tranqulity/core/ui/app_images.dart';

class ProfileImagePicker extends StatefulWidget {
  final String icon;

  const ProfileImagePicker({super.key, required this.icon});

  @override
  State<ProfileImagePicker> createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  final ImagePicker imagePicker = ImagePicker();
  File? selectedImage;

  Future<void> imageSelector(ImageSource source) async {
    XFile? image = await imagePicker.pickImage(source: source);
    if (image != null && mounted) {
      setState(() {
        selectedImage = File(image!.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 60.h),
        Center(
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: Colors.grey[400],
                child: selectedImage == null
                    ? AppImage(
                        image: 'not_image.png',
                        width: 54.5.w,
                        height: 54.5.h,
                      )
                    : ClipOval(
                        child: Image.file(
                          selectedImage!,
                          height: 170.h,
                          width: 170.w,
                          fit: BoxFit.cover,
                        ),
                      ),
              ),
              CircleAvatar(
                radius: 25,
                backgroundColor: Color(0xff284243),
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) => SizedBox(
                        height: 150.h,
                        child: Column(
                          children: [
                            Text(
                              'Profile',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _Profile(
                                  icon: Icon(Icons.camera_alt),
                                  text: 'Camera',
                                  onPressed: () {
                                    imageSelector(ImageSource.camera);
                                  },
                                ),
                                _Profile(
                                  icon: Icon(Icons.image),
                                  text: 'Gallery',
                                  onPressed: () {
                                    imageSelector(ImageSource.gallery);
                                  },
                                ),
                                if (selectedImage != null)
                                  _Profile(
                                    icon: Icon(Icons.delete),
                                    text: 'Dalet',
                                    isColor: true,
                                    onPressed: () {
                                      if (mounted) {
                                        setState(() {
                                          selectedImage = null;
                                        });
                                      }
                                    },
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
                    height: 25.6.h,
                    width: 25.6.w,
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

class _Profile extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function() onPressed;
  final bool isColor;

  const _Profile({
    super.key,
    required this.text,
    required this.icon,
    required this.onPressed,
    this.isColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: icon,
          color: isColor ? Colors.red : null,
        ),
        Text(text),
      ],
    );
  }
}
