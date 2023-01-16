import 'package:get/get.dart';

import '../../../../model/models/merchant_info_model/merchant_model.dart';
import '../../../../model/network_calls/api_helper/provider_helper/profile_provider.dart';
import '../../../../model/network_calls/dio_client/get_it_instance.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';

class KycController extends GetxController{
  ProfileProvider profileProvider =getIt();
  Rx<MerchantDataModel>merchantData=MerchantDataModel().obs;
  Rx<Kyc>kycInfo=Kyc().obs;
  Future getStoreInfo()async{
    try{
      await profileProvider.storeInfoTap(onError:(errorMessage){}, onSuccess:(message,data)async{
        if(data!=null){
          merchantData.value = MerchantDataModel.fromJson(data);
          kycInfo.value = merchantData.value.kyc!;
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