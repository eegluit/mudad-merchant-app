
import 'package:mudad_merchant/model/network_calls/api_helper/repository_helper/store_registration_repo.dart';

import '../../../models/network_call_model/api_response.dart';
import '../../../models/network_call_model/error_response.dart';
import '../../../models/network_call_model/store_register_response_model.dart';

class StoreRegistrationProvider {
  final StoreRegistrationRepo storeRegistrationRepo;
  StoreRegistrationProvider({required this.storeRegistrationRepo});

  Future storeRegistrationTap(Map<String, dynamic> storeRegistrationBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    StoreRegisterResponseModel apiResponse = await storeRegistrationRepo.storeRegistration(storeRegistrationBody);
    if (apiResponse.response != null && apiResponse.response!=null ? apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
      Map<String, dynamic> map = apiResponse;
      String message = "success";
      onSuccess(message, map);
    } else {
      String errorMessage;
      if (apiResponse.error is String) {
        errorMessage = apiResponse.error.toString();
      } else {
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message!;
      }
      onError(errorMessage);
    }
  }




}
