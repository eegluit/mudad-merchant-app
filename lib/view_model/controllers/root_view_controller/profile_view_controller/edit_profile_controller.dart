import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mudad_merchant/view/widgets/log_print/log_print_condition.dart';
import 'package:mudad_merchant/view/widgets/toast_view/showtoast.dart';
import '../../../../model/network_calls/api_helper/provider_helper/auth_provider.dart';
import '../../../../model/network_calls/api_helper/provider_helper/profile_provider.dart';
import '../../../../model/network_calls/dio_client/get_it_instance.dart';
import '../../../../model/services/auth_service.dart';


class EditProfileController extends GetxController{
  ProfileProvider profileProvider =getIt();
  AuthProvider authProvider = getIt();
  final picker = ImagePicker();
  RxBool isLoading = false.obs;
  late Rx<File> image = File("").obs;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController  = TextEditingController(text: Get.find<AuthService>().user.value.name??"");
  TextEditingController emailController  = TextEditingController(text:Get.find<AuthService>().user.value.email??"");
  TextEditingController phoneNumberController  = TextEditingController(text: Get.find<AuthService>().user.value.mobile??"" );
  RxString nameError = "".obs;
  RxString emailError = "".obs;
  RxString phoneNumberError = "".obs;
  imgFromGallery(bool updatePartialProfile) {
    picker.getImage(source: ImageSource.gallery,imageQuality: 30).then((pickedFile) async {
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }  else {
        logPrint('No image selected.');
      }
    }).catchError((e){logPrint(e);});
  }
  imgFromCamera(bool updatePartialProfile) {
    picker.getImage(source: ImageSource.camera,imageQuality: 30).then((pickedFile) async {
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }  else {
        logPrint('No image selected.');
      }
    }).catchError((e){logPrint(e);});
  }

  Future updateUserInfo()async{
    if(formKey.currentState!.validate() &&  isLoading.value == false){
      isLoading.value=true;
      try{
        await profileProvider.updatePersonalInfo(
            userData: {
              "name":nameController.text,
              "email":emailController.text,
              "mobile":phoneNumberController.text
            }, onError:(errorMessage){
          isLoading.value=false;
              toastShow(massage: errorMessage??"Something want wrong here",error: true);
        }, onSuccess:(message,data)async{
          if(data!=null){
            await authProvider.userProfile(onError:(errorMessage){}, onSuccess:(message,data)async{
              await Get.find<AuthService>().saveUser(data!);
              toastShow(massage:"Profile updated successfully",error: false);
              isLoading.value = false;
            });
          }
        });
      }catch(e){logPrint(e);isLoading.value=false;}
    }

  }
}