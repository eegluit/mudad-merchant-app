import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/services/auth_service.dart';
import 'package:mudad_merchant/view/widgets/image_picker/image_selection_util.dart';
import 'package:mudad_merchant/view_model/routes/app_pages.dart';

import '../../../model/network_calls/api_helper/provider_helper/auth_provider.dart';
import '../../../model/network_calls/api_helper/provider_helper/kyc_provider.dart';
import '../../../model/network_calls/dio_client/get_it_instance.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/identity_view.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/selecte_id_view.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/selfie_view.dart';
import '../../../view/screens/auth_view/verification_view/view_holder/verification_process_view.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';
import '../../../view/widgets/toast_view/showtoast.dart';
import '../../model/select_type_model.dart';

class VerificationController extends GetxController{
  KycProvider kycProvider = getIt();
  AuthProvider authProvider = getIt();
  var isLoading = false.obs;
  List<String> verifyIdentityList = <String>[
    'Your identification document',
    'A quick selfie',
  ];
  List<SelectTypeModel> typeList = [
    SelectTypeModel(
      id: 1,
      name: "Passport",
    ),
    SelectTypeModel(
      id: 2,
      name: "ID Card",
    ),
    SelectTypeModel(
      id: 3,
      name: "Drivers License",
    ),
  ];
  var typeId = 0.obs;
  List<Widget> verifyWidgetList = <Widget>[
    const IdentityWidget(),
    const SelectIdWidget(),
    const SelfieWidget(),
    VerificationProcessWidget()
  ];
  RxInt currentStep = 1.obs;
  RxInt selectedId = (-1).obs;
  RxBool isVerified = true.obs;
  Rx<File> selectedIdPic = File("").obs;
  Rx<File> selectSelfie = File("").obs;
  List<VerifyPage> verifyPageDataList = <VerifyPage>[
    VerifyPage(
        title: "Verify Your Identity",
        subTitle: "Simply use your phone camera to capture the following: "
    ),
    VerifyPage(
        title: "Select ID Type",
        subTitle: ""
    ),
    VerifyPage(
        title: "Take a Selfie",
        subTitle: "Place your face inside the oval and press start when you are ready"
    ),
    VerifyPage(
        title: "Verification\nProcess ",
        subTitle: ""
    ),
  ];

  late ImageSelectionUtil imageSelectionUtils = ImageSelectionUtil((String base64Image,File imageFiles) async {
    if(currentStep.value == 2){
      selectedIdPic.value = imageFiles;
    }else{
    selectSelfie.value = imageFiles;
    }
  });

  openSelfieCamera(){
    imageSelectionUtils.pickImageViaCamera();
  }

  /// on Verify Identity
  onVerifyIdentity(){
    currentStep.value = 2;
  }

  onSelectId()async{
   if(isLoading.value==false){
     try {
       isLoading.value = true;
       await kycProvider.registerTap({"kycIdType":typeList[selectedId.value].name}, onError: (errorMessage){
         toastShow(massage: errorMessage,error: true);
         isLoading.value = false;
       }, onSuccess: (message,data)async{
         await kycProvider.uploadIdProof({"file": selectedIdPic.value}, onError: (errorMessage){
           logPrint("errorMessage=> $errorMessage");
           toastShow(massage: errorMessage,error: true);
           isLoading.value = false;
         }, onSuccess: (message,data){
           isLoading.value = false;
           toastShow(massage: "Your document uploaded successfully.",error: false);
           currentStep.value = 3;
         });
       });
     } catch (e) {
       isLoading.value = false;
       logPrint("this is login try error ${e.toString()}");
       toastShow(massage: "Something want wrong here.",error: true);

     }
   }

  }

  onTakeSelfie()async{
   if(isLoading.value==false){
     if(selectSelfie.value.path == ""){
       openSelfieCamera();
     }else{
       isLoading.value=true;
       await kycProvider.selfieUpload({"file": selectSelfie.value}, onError: (errorMessage){
         logPrint("errorMessage=> $errorMessage");
         toastShow(massage: errorMessage,error: true);
         isLoading.value = false;
       }, onSuccess: (message,data){
         toastShow(massage: "Your selfie uploaded successfully.",error: false);
         currentStep.value = 4;
         isLoading.value = false;
       });
     }
   }

  }
  onVerificationComplete()async{
    await authProvider.userProfile(onError:(errorMessage){}, onSuccess:(message,data)async{
      await Get.find<AuthService>().saveUser(data!);
      if(Get.find<AuthService>().user.value.storeRegistered==false || Get.find<AuthService>().user.value.storeRegistered==null){
        Get.toNamed(Routes.storeRegistrationScreen);
      }else{
        Get.toNamed(Routes.rootView);
      }
      isLoading.value = false;
    });

  }
  onSkipNowButton(){}
}


class VerifyPage {
  final String title;
  final String subTitle;

  VerifyPage({required this.title,required this.subTitle});

}