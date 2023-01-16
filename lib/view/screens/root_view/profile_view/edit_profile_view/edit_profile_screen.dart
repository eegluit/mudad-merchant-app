import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/view/widgets/text_field_view/regex/regex.dart';

import '../../../../../model/utils/resource/color_resource.dart';
import '../../../../../view_model/controllers/root_view_controller/profile_view_controller/edit_profile_controller.dart';
import '../../../../widgets/button_view/common_button.dart';
import '../../../../widgets/text_field_view/common_textfield.dart';
import '../../../../widgets/view_helpers/back_button_bar_ui.dart';
import '../../../base_view/base_view_screen.dart';
import '../../../base_view/main_view_screen.dart';
import 'view_holder/image_box.dart';
class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: EditProfileController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "Edit Personal information",),
      body: _buildEditProfileBody(context,controller),
    ));
  }
}
Widget _buildEditProfileBody(BuildContext context ,EditProfileController controller){
  return Obx(()=>Form(
    key: controller.formKey,
    child: ListView(
      padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
      children: [
        const Center(child: ProfileImagePox(updatePartialProfile: false,)),
        const SizedBox(height: 30,),
        CommonTextField(
          label: "Name",
          controller: controller.nameController,
          keyboardType: TextInputType.name,
          hintText: "Enter your name.".tr,
          validator: (value) {
            if (value!.isEmpty) {
              controller.nameError.value = "Please enter your name.".tr;
              return "";
            } else if (value.removeAllWhitespace == "") {
              controller.nameError.value = "Please enter valid name.".tr;
              return null;
            } else {
              controller.nameError.value = "";
              return null;
            }
          },
          errorText: controller.nameError.value,
        ),
        const SizedBox(height: 30,),
        CommonTextField(
          label: "Email",
          readOnly: true,
          controller: controller.emailController,
          keyboardType: TextInputType.emailAddress,
          hintText: "Enter your email address.".tr,
          validator: (value) {
            if (value!.isEmpty) {
              controller.emailError.value = "Please enter your email address.".tr;
              return "";
            } else if (!value.isValidEmail()) {
              controller.emailError.value = "Please enter valid email address.".tr;
              return "";
            } else {
              controller.emailError.value = "";
              return null;
            }
          },
          errorText: controller.emailError.value,
        ),
        const SizedBox(height: 30,),
        CommonTextField(
          label: "Phone Number",
          controller: controller.phoneNumberController,
          keyboardType: TextInputType.number,
          hintText: "Enter your phone number.".tr,
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9 ]")),
            LengthLimitingTextInputFormatter(10),
          ],
          validator: (value) {
            if (value!.isEmpty) {
              controller.phoneNumberError.value = "Please enter your phone number.".tr;
              return "";
            } else if (!value.isValidNumber()) {
              controller.phoneNumberError.value = "Please enter valid phone number.".tr;
              return "";
            } else {
              controller.phoneNumberError.value = "";
              return null;
            }
          },
          errorText: controller.phoneNumberError.value,
        ),
        const SizedBox(height: 40,),
        Obx(()=>CommonButton(text: "Update Profile",color: ColorResource.mainColor,onPressed:()=>controller.updateUserInfo(),loading: controller.isLoading.value,))

      ],
    ),
  ));
}
