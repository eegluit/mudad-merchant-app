

import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';
import '../../../models/network_call_model/api_response.dart';
import '../../../utils/resource/app_constants.dart';
import '../../dio_client/dio_client.dart';
import '../../exception/api_error_handler.dart';

class ProfileRepo {
  final DioClient dioClient;
  ProfileRepo({
    required this.dioClient,
  });

  Future<ApiResponse> storeInfo() async {
    try {
      Response response = await dioClient.get(AppConstants.instance.getMerchantInfoUrl,);
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  Future<ApiResponse> updatePersonalInfo(Map<String,dynamic> userData) async {
    try {
      Response response = await dioClient.post(AppConstants.instance.updateUserPersonalInfoUrl,data: jsonEncode(userData));
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
