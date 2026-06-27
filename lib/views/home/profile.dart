import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:dio/dio.dart';
import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/ui/app_buttom.dart';
import '../../core/ui/app_input.dart';
import '../../core/ui/image_picker.dart';
import '../../core/ui/type_male.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File? selectedImage;

  final emailController = TextEditingController();
  final ageController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final genderController = DropdownController();

  bool isLoading = true;
  bool isSaving = false;

  String? imageUrl;

  @override
  void initState() {
    super.initState();
    getProfile();
  }

  @override
  void dispose() {
    emailController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> getProfile() async {
    setState(() => isLoading = true);

    try {
      final resp = await DioHelper.getData('api/Profile');

      if (resp.isSuccess && resp.data != null) {
        final data = resp.data;

        emailController.text = data['email'] ?? '';
        ageController.text = (data['age'] ?? '').toString();
        genderController.value = data['gender'] ?? '';
        imageUrl = data['imageUrl'];
      } else {
        showMsg("Failed to load profile");
      }
    } catch (e) {
      showMsg("Error loading profile");
    }

    if (mounted) {
      setState(() => isLoading = false);
    }
  }
  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    setState(() => isSaving = true);

    final formData = FormData.fromMap({
      "age": ageController.text,
      "gender": genderController.value,

      if (selectedImage != null)
        "image": await MultipartFile.fromFile(
          selectedImage!.path,
          filename: selectedImage!.path.split('/').last,
        ),
    });

    final resp = await DioHelper.putData(
      'api/Profile',
      data: formData,
    );

    setState(() => isSaving = false);

    if (resp.isSuccess) {
      showMsg("Profile Updated Successfully");
      await getProfile();
    } else {
      print(resp.data);
      showMsg("Update failed");
    }
  }  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                SizedBox(height: 20.h),
                ProfileImagePicker(
                  icon: 'edit.svg',
                  imageUrl: imageUrl,
                  onChanged: (file) {
                    setState(() {
                      selectedImage = file;
                    });
                  },
                ),

                SizedBox(height: 30.h),
                AppInput(
                  controller: emailController,
                  hint: 'Email',
                  textInputType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value!.isEmpty) return "Enter Your Email";
                    return null;
                  },
                ),

                AppInput(
                  controller: ageController,
                  hint: 'Age',
                  textInputType: TextInputType.number,
                  withType: true,
                  dropdownController: genderController,
                  validator: (value) {
                    if (value!.isEmpty) return "Enter age";
                    return null;
                  },
                ),

                SizedBox(height: 30.h),

                AppButtom(
                  text: isSaving ? "Saving..." : "Save",
                  onPressed: isSaving ? null : updateProfile,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}