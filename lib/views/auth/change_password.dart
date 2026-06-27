import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tranqulity/core/ui/app_buttom.dart';
import 'package:tranqulity/core/ui/app_input.dart';

import '../../core/logic/dio_helper.dart';
import '../../core/logic/helper_methods.dart';
import '../../core/ui/app_images.dart';

class ChangePasswordView extends StatefulWidget {
  const ChangePasswordView({super.key});

  @override
  State<ChangePasswordView> createState() => _ChangePasswordViewState();
}

class _ChangePasswordViewState extends State<ChangePasswordView> {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  DataState? state;

  Future<void> changePassword() async {
    if (newPasswordController.text !=
        confirmPasswordController.text) {
      showMsg(
        'Passwords do not match',
        isError: true,
      );
      return;
    }
    state = DataState.loading;
    setState(() {});

    final formData = FormData.fromMap({
      'OldPassword': oldPasswordController.text.trim(),
      'NewPassword': newPasswordController.text.trim(),
      'ConfirmNewPassword': confirmPasswordController.text.trim(),
    });

    final resp = await DioHelper.sendData(
      'api/Auth/change-password',
      data: formData,
    );

    if (resp.isSuccess) {
      state = DataState.success;
      showMsg(resp.message ?? 'Password changed successfully');

      Navigator.pop(context);
    } else {
      state = DataState.failed;
      showMsg(resp.message ?? 'Failed to change password', isError: true);
    }

    setState(() {});
  }

  @override
  void dispose() {
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24).r,
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppImage(image: 'chanegd_password.png'),
            SizedBox(height: 23.h),
            Text(
              'Change Your Password',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            SizedBox(height: 24.h),
            AppInput(
              hint: 'Old Password',
              isbass: true,
              textInputType: TextInputType.text,
              controller: oldPasswordController,
            ),
            AppInput(
              hint: 'New Password',
              isbass: true,
              textInputType: TextInputType.text,
              controller: newPasswordController,
            ),
            AppInput(
              hint: 'Confirm New Password',
              isbass: true,
              textInputType: TextInputType.text,
              controller: confirmPasswordController,
            ),
            SizedBox(height: 36.h),
            AppButtom(
              text: state == DataState.loading
                  ? 'Loading...'
                  : 'Change Password',
              onPressed: state == DataState.loading
                  ? null
                  : changePassword,
            ),          ],
        ),
      ),
    );
  }
}
