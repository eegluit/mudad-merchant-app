import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';


import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/style_resource.dart';
import '../../../view_model/controllers/auth_controllers/verify_otp_controller.dart';
import '../../widgets/button_view/common_button.dart';
import '../../widgets/button_view/textbutton.dart';
import '../base_view/base_view_screen.dart';

class VerifyOtpScreen extends StatelessWidget {
  const VerifyOtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(
      appbarPerimeter: AppbarPerimeter(
        elevation: 0,
        appBarBackGroundColor: ColorResource.white,
        backButtonColor: ColorResource.black,
        title: ""
      ),
        viewControl: VerifyOtpController(),
        onPageBuilder: (BuildContext context, VerifyOtpController controller) => _buildVerifyOtpView(context,controller));
  }
}
Widget _buildVerifyOtpView(BuildContext context, VerifyOtpController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    children: [
      SizedBox(height: MediaQuery.of(context).size.height*.08,),
      Center(child: Text("OTP Verification",style:  StyleResource.instance.styleExtraBold(DimensionResource.fontSizeDoubleOverExtraLarge, ColorResource.mainColor).copyWith(fontSize: 35),)),
      SizedBox(height: MediaQuery.of(context).size.height*.05,),
      Text(
        "Please enter the OTP sent to\n${controller.backData.containsKey("email")?controller.backData["email"]:""}",
        style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.black),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: MediaQuery.of(context).size.height*.08,),
      Center(
        child: Pinput(
          defaultPinTheme: PinTheme(
            width: 58,
            height: 58,
            textStyle: const TextStyle(
              fontSize: 18,
              color: ColorResource.secondColor,
              fontWeight: FontWeight.w500,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: ColorResource.mainColor,
                width: 3,
              ),
            ),
          ),
          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
          showCursor: true,
          onCompleted: (pin) =>controller.otpController.value.text = pin,
        ),
      ),
      const SizedBox(
        height: 30,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Didn't receive a code? ",
            style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.black),
            textAlign: TextAlign.center,
          ),
          Obx(() {
            return Visibility(
                visible:
                controller.start.value != 0 ? true : false,
                child: RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(
                          text: " 00 : ${controller.start}",
                          style:StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.secondColor)),
                    ],
                  ),
                ));
          }),
          Obx(() => Visibility(
              visible: controller.start.value == 0 ? true : false,
              child: textBottomWithoutUnderLine(" Resend".tr, controller.resendOtp)))
        ],
      ),
      const SizedBox(
        height: 40,
      ),
      Obx(()=>CommonButton(text: "Submit",color: ColorResource.mainColor,onPressed: controller.checkOtp,loading: controller.isLoading.value,),),
    ],
  );
}
