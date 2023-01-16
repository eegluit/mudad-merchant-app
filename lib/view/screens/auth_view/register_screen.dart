import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mudad_merchant/view/widgets/text_field_view/regex/regex.dart';


import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/image_resource.dart';
import '../../../model/utils/resource/style_resource.dart';
import '../../../view_model/controllers/auth_controllers/register_controller.dart';
import '../../widgets/button_view/common_button.dart';
import '../../widgets/button_view/textbutton.dart';
import '../../widgets/text_field_view/common_textfield.dart';
import '../base_view/base_view_screen.dart';
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: RegisterController(), onPageBuilder: (BuildContext context,RegisterController controller)=>_buildLoginView(context,controller));
  }
}
Widget _buildLoginView(BuildContext context,RegisterController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      SizedBox(height: MediaQuery.of(context).size.height*.1,),
      Image.asset(ImageResource.instance.appLogo,height: 60,),
      SizedBox(height: MediaQuery.of(context).size.height*.08,),
      _buildEmailPasswordRow(context,controller),

      const SizedBox(height: 50,),
      Obx(()=>  CommonButton(text: "Register",color: ColorResource.mainColor,onPressed:controller.registerTap,loading: controller.isLoading.value,),),

      const SizedBox(height: 20,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.black),
            textAlign: TextAlign.center,
          ),
          textBottomWithoutUnderLine("Sign in here".tr,()=>Get.back()),
        ],
      ),
      const SizedBox(height: 50,),

    ],
  );
}

Widget _buildEmailPasswordRow(BuildContext context,RegisterController controller){
  return Form(
    key: controller.registerFormKey,
    child: Obx(()=>Column(
      children: [
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
              controller.nameError.value = "Please enter valid nmae.".tr;
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
          controller: controller.emailController,

          keyboardType: TextInputType.emailAddress,

          hintText: "Enter your email address.".tr,
          validator: (value) {
            if (value!.isEmpty) {
              controller.emailError.value = "Please enter your email.".tr;
              return "";

            } else if (!value.isValidEmail()) {

              controller.emailError.value = "Please enter valid email.".tr;
              return null;
            } else {
              controller.emailError.value = "";
              return null;
            }
          },
          errorText: controller.emailError.value,
        ),
        const SizedBox(height: 30,),
        CommonTextField(
          label: "Password",
          suffixIcon: true,
          controller: controller.passwordController,

          keyboardType: TextInputType.name,

          hintText: "Enter your password.".tr,
          validator: (value) {
            if (value!.isEmpty) {
              controller.passwordError.value = "Please enter your password.".tr;
              return "";
            } else if (value.removeAllWhitespace == "") {
              controller.passwordError.value = "Please enter valid password.".tr;
              return "";
            } else if (!value.isValidPassword()) {
              controller.passwordError.value = "Please enter strong password and length must be grater then 8 digit.".tr;
              return "";

            } else {
              controller.passwordError.value = "";
              return null;
            }
          },
          errorText: controller.passwordError.value,
        ),
        const SizedBox(height: 30,),
        CommonTextField(
          label: "Confirm Password",
          suffixIcon: true,
          controller: controller.confirmPasswordController,

          keyboardType: TextInputType.name,

          hintText: "Re-type your password.".tr,
          validator: (value) {
            if (value!.isEmpty) {
              controller.confirmPasswordError.value = "Please enter your confirm password.".tr;
              return "";
            } else if (value.removeAllWhitespace == "") {
              controller.confirmPasswordError.value = "Please enter valid confirm password.".tr;
              return "";

            } else if (controller.passwordController.text!=controller.confirmPasswordController.text) {
              controller.confirmPasswordError.value = "password and confirm password must be same.".tr;
              return "";
            }
            else {

              controller.confirmPasswordError.value = "";
              return null;
            }
          },
          errorText: controller.confirmPasswordError.value,
        ),
      ],
    )),
  );
}