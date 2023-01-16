
import '../../../models/network_call_model/api_response.dart';
import '../../../models/network_call_model/error_response.dart';
import '../repository_helper/kyc_repo.dart';

class KycProvider {
  final KycRepo kycRepo;
  KycProvider({required this.kycRepo});

  Future registerTap(Map<String, dynamic> verifyIdentityBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await kycRepo.verifyIdentity(verifyIdentityBody);
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


  Future uploadIdProof(Map<String, dynamic> uploadIdProofBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await kycRepo.uploadIdProof(uploadIdProofBody);
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

  Future selfieUpload(Map<String, dynamic> selfieUploadBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await kycRepo.selfieUpload(selfieUploadBody);
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
