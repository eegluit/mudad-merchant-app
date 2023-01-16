import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/network_calls/dio_client/get_it_instance.dart';
import 'package:mudad_merchant/view/widgets/log_print/log_print_condition.dart';

import '../../../../model/models/merchant_info_model/merchant_model.dart';
import '../../../../model/network_calls/api_helper/provider_helper/profile_provider.dart';

class StoreInfoController extends GetxController{
  ProfileProvider profileProvider =getIt();
  Rx<MerchantDataModel>merchantData=MerchantDataModel().obs;
  Rx<Store>storeInfo=Store().obs;
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
  Future getStoreInfo()async{
   try{
     await profileProvider.storeInfoTap(onError:(errorMessage){}, onSuccess:(message,data)async{
      if(data!=null){
        merchantData.value = MerchantDataModel.fromJson(data);
        storeInfo.value = merchantData.value.store!;
        nameController.text = storeInfo.value.name??"";
        addressController.text = storeInfo.value.address??"";
        latController.text = storeInfo.value.lat??"";
        lngController.text = storeInfo.value.long??"";
      }
     });
   }catch(e){logPrint(e);}
  }
  @override
  void onInit() {
    getStoreInfo();
    super.onInit();
  }
}