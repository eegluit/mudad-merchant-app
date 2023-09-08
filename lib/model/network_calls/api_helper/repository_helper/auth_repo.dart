import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_pack;
import '../../../services/auth_service.dart';
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
    var token = get_pack.Get.find<AuthService>().getUserToken();
    try {
      Response response = await Dio().post(
        AppConstants.instance.registerUrl,
        data: json.encode(signInBody),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'authentication': 'Bearer $token'},
        ),
      );
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> login(Map<String, dynamic> loginBody) async {
    try {
      Response response = await Dio().post(
        AppConstants.instance.loginUrl,
        data: json.encode(loginBody),
        options: Options(
          contentType: Headers.jsonContentType,
        ),
      );
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> otpVerify(Map<String, dynamic> otpVerifyBody) async {
    var token = get_pack.Get.find<AuthService>().getUserToken();
    try {
      Response response = await Dio().post(
        AppConstants.instance.otpVerifyUrl,
        data: json.encode(otpVerifyBody),
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'authentication': 'Bearer $token'},
        ),
      );
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> resendOtp() async {
    var token = get_pack.Get.find<AuthService>().getUserToken();
    try {
      Response response = await Dio().get(
        AppConstants.instance.resendOtpUrl,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'authentication': 'Bearer $token'},
        ),
      );
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> getUserData() async {
    var token = get_pack.Get.find<AuthService>().getUserToken();
    try {
      Response response = await Dio().get(
        AppConstants.instance.userProfileUrl,
        options: Options(
          contentType: Headers.jsonContentType,
          headers: {'authentication': 'Bearer $token'},
        ),
      );
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
