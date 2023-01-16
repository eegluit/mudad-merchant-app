import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/network_calls/dio_client/get_it_instance.dart';
import 'package:mudad_merchant/view/widgets/toast_view/showtoast.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';

import '../../../model/network_calls/api_helper/provider_helper/auth_provider.dart';
import '../../../model/network_calls/api_helper/provider_helper/store_registration_provider.dart';
import '../../../model/services/auth_service.dart';
import '../../../view/widgets/image_picker/image_selection_util.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';

class StoreRegistrationController extends GetxController{
  StoreRegistrationProvider storeRegistrationProvider = getIt();
  AuthProvider authProvider = getIt();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController nameController  = TextEditingController();
  TextEditingController addressController  = TextEditingController();
  TextEditingController latController  = TextEditingController();
  TextEditingController lngController  = TextEditingController();
  RxString nameError = "".obs;
  RxString addressError = "".obs;
  RxString latError = "".obs;
  RxString lngError = "".obs;
  var isLoading = false.obs;
  Rx<File> selectLogo = File("").obs;

  late ImageSelectionUtil imageSelectionUtils =
  ImageSelectionUtil((String base64Image,File imageFiles) async {
    selectLogo.value = imageFiles;
  });

  openImagePicker(){
    imageSelectionUtils.pickImageViaGallery();
  }

  onSubmit()async{
    if((formKey.currentState?.validate()??false) && selectLogo.value.path != "" && isLoading.value==false){
      isLoading.value=true;
      await storeRegistrationProvider.storeRegistrationTap({
        "name":nameController.text,
        "address":addressController.text,
        "lat":latController.text,
        "long":lngController.text,
        "image":selectLogo.value,
      }, onError: (errorMessage){
        logPrint("errorMessage=> $errorMessage");
        toastShow(massage: errorMessage,error: true);
        isLoading.value = false;
      }, onSuccess: (message,data)async{
        await authProvider.userProfile(onError:(errorMessage){}, onSuccess:(message,data)async{
          await Get.find<AuthService>().saveUser(data!);
          Get.toNamed(Routes.rootView);
          toastShow(massage: "Your store registered successfully.",error: false);
          isLoading.value = false;
        });
      });
    }else{
      if(selectLogo.value.path == ""){
        toastShow(massage: "Please select logo");
      }
    }
  }

}