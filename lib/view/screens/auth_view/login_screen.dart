import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mudad_merchant/view/screens/base_view/base_view_screen.dart';

import 'package:mudad_merchant/view/widgets/text_field_view/regex/regex.dart';

import 'package:mudad_merchant/view_model/routes/app_pages.dart';

import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/image_resource.dart';
import '../../../model/utils/resource/style_resource.dart';
import '../../../view_model/controllers/auth_controllers/login_controller.dart';
import '../../widgets/button_view/common_button.dart';
import '../../widgets/button_view/textbutton.dart';
import '../../widgets/text_field_view/common_textfield.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  GlobalKey<FormState> logInKey = GlobalKey<FormState>(debugLabel: '_login');
  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: LoginController(), onPageBuilder: (BuildContext context,LoginController controller)=>_buildLoginView(context,controller,logInKey));
  }
}
Widget _buildLoginView(BuildContext context,LoginController controller,GlobalKey<FormState>  key){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      SizedBox(height: MediaQuery.of(context).size.height*.1,),
      Image.asset(ImageResource.instance.appLogo,height: 60,),
      SizedBox(height: MediaQuery.of(context).size.height*.1,),
      _buildEmailPasswordRow(context,controller,key),
      const SizedBox(height: 10,),
      textBottomWithoutUnderLine("Forgot Password?".tr,()=>Get.toNamed(Routes.forgotPasswordScreen)),
      const SizedBox(height: 50,),
      Obx(()=>  CommonButton(text: "Login",color: ColorResource.mainColor,onPressed:(){
        if(key.currentState!.validate()){
          controller.loginTap();
        }
      },loading: controller.isLoading.value,),),
      const SizedBox(height: 20,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "Don’t have an account yet?",
            style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.black),
            textAlign: TextAlign.center,
          ),
          textBottomWithoutUnderLine(" Register here".tr,()=>Get.toNamed(Routes.registerScreen)),
        ],
      ),
      const SizedBox(height: 50,),

    ],
  );
}

Widget _buildEmailPasswordRow(BuildContext context,LoginController controller,GlobalKey key){
  return Form(
    key: key,
    child: Obx(()=>Column(
      children: [
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
            } else {
              controller.passwordError.value = "";
              return null;
            }
          },
          errorText: controller.passwordError.value,
        ),
      ],
    )),
  );
}

