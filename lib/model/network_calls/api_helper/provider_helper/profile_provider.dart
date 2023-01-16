

import '../../../models/network_call_model/api_response.dart';
import '../../../models/network_call_model/error_response.dart';
import '../repository_helper/profile_repo.dart';

class ProfileProvider {
  final ProfileRepo profileRepo;
  ProfileProvider({required this.profileRepo});

  Future storeInfoTap({required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await profileRepo.storeInfo();
    if (apiResponse.response != null && apiResponse.response!=null ? apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
      Map<String, dynamic> map = apiResponse.response!.data;
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


  Future updatePersonalInfo({required Map<String,dynamic> userData,required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await profileRepo.updatePersonalInfo(userData);
    if (apiResponse.response != null && apiResponse.response!=null ? apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
      Map<String, dynamic> map = apiResponse.response!.data;
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
