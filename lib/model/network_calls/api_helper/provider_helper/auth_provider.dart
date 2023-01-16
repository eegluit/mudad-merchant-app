
import 'package:mudad_merchant/view/widgets/log_print/log_print_condition.dart';

import '../../../models/network_call_model/api_response.dart';
import '../../../models/network_call_model/error_response.dart';
import '../repository_helper/auth_repo.dart';

class AuthProvider {
  final AuthRepo authRepo;
  AuthProvider({required this.authRepo});

  Future registerTap(Map<String, dynamic> signInBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await authRepo.register(signInBody);
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

  Future loginTap(Map<String, dynamic> loginBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await authRepo.login(loginBody);
    if (apiResponse.response != null && apiResponse.response!=null?apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
      Map<String, dynamic> map = apiResponse.response!.data;
      String message = "success";
      onSuccess(message, map);
    } else {
      String errorMessage;
      logPrint("in else");
      if (apiResponse.error is String) {
        logPrint("in");
        errorMessage = apiResponse.error.toString();
      } else {
        logPrint("out");
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message!;
      }
      onError(errorMessage);
    }
  }

  Future otpVerifyTap(Map<String, dynamic> otpBody,{required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await authRepo.otpVerify(otpBody);
    if (apiResponse.response != null && apiResponse.response!=null?apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
      Map<String, dynamic> map = apiResponse.response!.data;
      String message = "success";
      onSuccess(message, map);
    } else {
      String errorMessage;
      logPrint("in else");
      if (apiResponse.error is String) {
        logPrint("in");
        logPrint(apiResponse.error.toString());
        errorMessage = apiResponse.error.toString();
      } else {
        logPrint("out");
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message!;
      }
      onError(errorMessage);
    }
  }

  Future resendOtpTap({required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await authRepo.resendOtp();
    if (apiResponse.response != null && apiResponse.response!=null?apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
      Map<String, dynamic> map = apiResponse.response!.data;
      String message = "success";
      onSuccess(message, map);
    } else {
      String errorMessage;
      logPrint("in else");
      if (apiResponse.error is String) {
        logPrint("in");
        errorMessage = apiResponse.error.toString();
      } else {
        logPrint("out");
        ErrorResponse errorResponse = apiResponse.error;
        errorMessage = errorResponse.errors![0].message!;
      }
      onError(errorMessage);
    }
  }

  Future userProfile({required Function(String? message) onError, required Function(String? message, Map<String, dynamic>? map)onSuccess}) async {
    ApiResponse apiResponse = await authRepo.getUserData();
    if (apiResponse.response != null && apiResponse.response!=null?apiResponse.response!.statusCode == 200 || apiResponse.response!.statusCode == 201:false) {
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
