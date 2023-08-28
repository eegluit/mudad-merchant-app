import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/view/widgets/text_field_view/regex/regex.dart';
import 'package:mudad_merchant/view/widgets/toast_view/showtoast.dart';

import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/image_resource.dart';
import '../../../model/utils/resource/style_resource.dart';
import '../../../view_model/controllers/auth_controllers/forgot_password_controller.dart';
import '../../../view_model/routes/app_pages.dart';
import '../../widgets/button_view/common_button.dart';
import '../../widgets/button_view/textbutton.dart';
import '../../widgets/text_field_view/common_textfield.dart';
import '../base_view/base_view_screen.dart';
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: ForgotPasswordController(), onPageBuilder: (BuildContext context,ForgotPasswordController controller)=>_buildForgotPasswordView(context,controller));
  }
}
Widget _buildForgotPasswordView(BuildContext context,ForgotPasswordController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      SizedBox(height: MediaQuery.of(context).size.height*.1,),
      Image.asset(ImageResource.instance.appLogo,height: 122,),
      SizedBox(height: MediaQuery.of(context).size.height*.1,),
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
      const SizedBox(height: 50,),
      CommonButton(text: "Send Otp",color: ColorResource.mainColor,onPressed:(){
        toastShow(massage: "Coming soon",error: false);
      },loading: false,),
      const SizedBox(height: 20,),
      Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "you remembered your password than ",
            style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.black),
            textAlign: TextAlign.center,
          ),
          textBottomWithoutUnderLine(" Login".tr,()=>Get.toNamed(Routes.loginScreen)),
        ],
      ),
      const SizedBox(height: 50,),

    ],
  );
}
