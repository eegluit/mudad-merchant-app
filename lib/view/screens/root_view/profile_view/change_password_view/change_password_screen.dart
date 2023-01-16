import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../model/utils/resource/color_resource.dart';
import '../../../../../view_model/controllers/root_view_controller/profile_view_controller/change_password_controller.dart';
import '../../../../widgets/button_view/common_button.dart';
import '../../../../widgets/text_field_view/common_textfield.dart';
import '../../../../widgets/view_helpers/back_button_bar_ui.dart';
import '../../../base_view/base_view_screen.dart';
import '../../../base_view/main_view_screen.dart';
class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: ChangePasswordController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "Update your password",),
      body: _buildChangePasswordBody(context,controller),
    ));
  }
}
Widget _buildChangePasswordBody(BuildContext context ,ChangePasswordController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      const SizedBox(height: 30,),
      CommonTextField(
        suffixIcon: true,
        label: "Old Password",
        controller: controller.oldPasswordController,
        keyboardType: TextInputType.name,
        hintText: "Enter your old password.".tr,
        validator: (value) {
          if (value!.isEmpty) {
            controller.oldPasswordError.value = "Please enter your old password.".tr;
            return "";
          } else if (value.removeAllWhitespace == "") {
            controller.oldPasswordError.value = "Please enter valid old password.".tr;
            return null;
          } else {
            controller.oldPasswordError.value = "";
            return null;
          }
        },
        errorText: controller.oldPasswordError.value,
      ),
      const SizedBox(height: 30,),
      CommonTextField(
        suffixIcon: true,
        label: "New Password",
        controller: controller.reEnterPasswordController,
        keyboardType: TextInputType.name,
        hintText: "Enter your new password.".tr,
        validator: (value) {
          if (value!.isEmpty) {
            controller.newPasswordError.value = "Please enter your new password.".tr;
            return "";
          } else if (value.removeAllWhitespace == "") {
            controller.newPasswordError.value = "Please enter valid new password.".tr;
            return "";
          } else {
            controller.newPasswordError.value = "";
            return null;
          }
        },
        errorText: controller.newPasswordError.value,
      ),
      const SizedBox(height: 30,),
      CommonTextField(
        suffixIcon: true,
        label: "Confirm Password",
        controller: controller.reEnterPasswordController,
        keyboardType: TextInputType.name,
        hintText: "Enter your re-enter password.".tr,
        validator: (value) {
          if (value!.isEmpty) {
            controller.reEnterPasswordError.value = "Please enter your re-enter password.".tr;
            return "";
          } else if (value.removeAllWhitespace == "") {
            controller.reEnterPasswordError.value = "Please enter valid re-enter password.".tr;
            return "";
          } else {
            controller.reEnterPasswordError.value = "";
            return null;
          }
        },
        errorText: controller.reEnterPasswordError.value,
      ),
      const SizedBox(height: 40,),
      CommonButton(text: "Submit",color: ColorResource.mainColor,onPressed:(){},loading: false,)

    ],
  );
}