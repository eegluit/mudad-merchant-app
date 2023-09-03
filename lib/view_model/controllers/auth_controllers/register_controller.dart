import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/models/user_model/user_model.dart';


import '../../../model/network_calls/api_helper/provider_helper/auth_provider.dart';
import '../../../model/network_calls/dio_client/get_it_instance.dart';
import '../../../model/services/auth_service.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';
import '../../../view/widgets/toast_view/showtoast.dart';
import '../../routes/app_pages.dart';
class RegisterController extends GetxController{
  AuthProvider authProvider = getIt();
  GlobalKey<FormState> registerFormKey = GlobalKey<FormState>(debugLabel: "register");
  TextEditingController nameController  = TextEditingController();
  TextEditingController emailController  = TextEditingController();
  TextEditingController passwordController  = TextEditingController();
  TextEditingController confirmPasswordController  = TextEditingController();
  RxString nameError = "".obs;
  RxString emailError = "".obs;
  RxString passwordError = "".obs;
  RxString confirmPasswordError = "".obs;
  RxBool isLoading = false.obs;


  VoidCallback get registerTap =>()async{
    if (registerFormKey.currentState!.validate() &&  isLoading.value == false) {
      isLoading.value = true;
      try {
        await authProvider.registerTap({
          "name":nameController.text,
          "email":emailController.text,
          "password":passwordController.text,
          "role": "merchant"
        }, onError: (message){
          isLoading.value = false;
          toastShow(massage: message??"Please try again",error: true);
          logPrint("login error => $message");
        }, onSuccess: (message,data)async{
          if(data != null){
            toastShow(massage:data.containsKey("message")?data["message"]:"OTP has been sent on the email",error: false);
            isLoading.value = false;
            await Get.find<AuthService>().saveUserToken(data.containsKey("tokens")?data["tokens"]:"");
            Map<String,dynamic> backData ={"email":emailController.text};
            Get.toNamed(Routes.verifyOtpScreen,arguments: backData);
          }
        });
      } catch (e) {
        logPrint("this is login try error ${e.toString()}");
        isLoading.value = false;
      }
    }
  };

}