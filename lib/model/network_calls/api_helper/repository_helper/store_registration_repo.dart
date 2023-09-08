import 'dart:convert';

import 'package:dio/dio.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';
import '../../../models/network_call_model/api_response.dart';
import '../../../services/auth_service.dart';
import '../../../utils/resource/app_constants.dart';
import '../../dio_client/dio_client.dart';
import '../../exception/api_error_handler.dart';
import 'package:http_parser/http_parser.dart';
import 'package:get/get.dart' as get_pack;

class StoreRegistrationRepo {
  final DioClient dioClient;
  StoreRegistrationRepo({
    required this.dioClient,
  });

  Future<ApiResponse> storeRegistration(Map<String, dynamic> storeRegistrationBody) async {
    FormData fileData = FormData.fromMap({
      "name":storeRegistrationBody["name"],
      "address":storeRegistrationBody["address"],
      "lat":storeRegistrationBody["lat"],
      "long":storeRegistrationBody["long"],
      "image": await MultipartFile.fromFile(storeRegistrationBody["image"].path, contentType:  MediaType("image", "jpg"), filename: storeRegistrationBody["image"].path.split('/').last,),
    });
    try {
      Response response = await Dio().post(AppConstants.instance.storeRegistrationUrl, data: fileData,options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
            'authentication': 'Bearer ${get_pack.Get.find<AuthService>().getUserToken()}'
          }
      ));
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

}
