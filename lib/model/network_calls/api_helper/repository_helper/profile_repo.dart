import 'dart:convert';
import 'package:get/get.dart' as get_pack;

import 'package:dio/dio.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';
import '../../../models/network_call_model/api_response.dart';
import '../../../utils/resource/app_constants.dart';
import '../../dio_client/dio_client.dart';
import '../../exception/api_error_handler.dart';
import '../../../services/auth_service.dart';

class ProfileRepo {
  final DioClient dioClient;
  ProfileRepo({
    required this.dioClient,
  });

  Future<ApiResponse> storeInfo() async {
    var token = get_pack.Get.find<AuthService>().getUserToken();
    try {
      Response response = await dioClient.get(
        AppConstants.instance.getMerchantInfoUrl,
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

  Future<ApiResponse> updatePersonalInfo(Map<String, dynamic> userData) async {
    try {
      var token = get_pack.Get.find<AuthService>().getUserToken();
      Response response = await dioClient.post(
        AppConstants.instance.updateUserPersonalInfoUrl,
        data: jsonEncode(userData),
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
