import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart' as get_pack;
import 'package:http_parser/http_parser.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';
import '../../../models/network_call_model/api_response.dart';
import '../../../services/auth_service.dart';
import '../../../utils/resource/app_constants.dart';
import '../../dio_client/dio_client.dart';
import '../../exception/api_error_handler.dart';

class KycRepo {
  final DioClient dioClient;
  KycRepo({
    required this.dioClient,
  });

  Future<ApiResponse> verifyIdentity(Map<String, dynamic> signInBody) async {
    var token = get_pack.Get.find<AuthService>().getUserToken();
    try {
      Response response = await Dio().post(
        AppConstants.instance.verifyIdentityUrl,
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


  Future<ApiResponse> uploadIdProof(Map<String, dynamic> uploadIdProofData) async {
    // FormData fileData = FormData.fromMap({
    //   "document": await MultipartFile.fromFile(
    //     uploadIdProofData["file"].path,
    //     contentType:  MediaType("image", "jpg"),
    //     filename: uploadIdProofData["file"].path.split('/').last,
    //   ),
    // });
    try {
      Response response = await dioClient.post(AppConstants.instance.uploadIdProofUrl, data: {
        'document': jsonEncode(uploadIdProofData),
      },
         options: Options(
              contentType: Headers.formUrlEncodedContentType,
        headers: {
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

  Future<ApiResponse> selfieUpload(
      Map<String, dynamic> uploadIdProofData) async {
    FormData fileData = FormData.fromMap({
      "document": await MultipartFile.fromFile(
        uploadIdProofData["file"].path,
        contentType: MediaType("image", "jpg"),
        filename: uploadIdProofData["file"].path.split('/').last,
      ),
    });
    try {
      Response response =
          await Dio().post(AppConstants.instance.selfieUploadUrl,
              data: fileData,
              options: Options(headers: {
                'Content-Type': 'multipart/form-data',
                'authentication':
                    'Bearer ${get_pack.Get.find<AuthService>().getUserToken()}'
              }));
      logPrint("response.data ${response.data}");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      logPrint("sign in error => $e");
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}
