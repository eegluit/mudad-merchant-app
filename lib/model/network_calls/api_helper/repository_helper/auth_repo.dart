import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../../view/widgets/log_print/log_print_condition.dart';
import '../../../models/network_call_model/api_response.dart';
import '../../../utils/resource/app_constants.dart';
import '../../dio_client/dio_client.dart';
import '../../exception/api_error_handler.dart';

class AuthRepo {

  final DioClient dioClient;
  AuthRepo({
    required this.dioClient,
  });

  Future<ApiResponse> register(Map<String, dynamic> signInBody) async {
    try {
      Response response = await dioClient.post(AppConstants.instance.registerUrl, data: json.encode(signInBody),);
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(Map<String, dynamic> loginBody) async {
    try {
      Response response = await dioClient.post( AppConstants.instance.loginUrl, data: json.encode(loginBody),);
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> otpVerify(Map<String, dynamic> otpVerifyBody) async {
    try {
      Response response = await dioClient.post( AppConstants.instance.otpVerifyUrl, data: json.encode(otpVerifyBody),);
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendOtp() async {
    try {
      Response response = await dioClient.get( AppConstants.instance.resendOtpUrl,);
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserData() async {
    try {
      Response response = await dioClient.get(AppConstants.instance.userProfileUrl,);
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
