import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import '../../../../view/widgets/log_print/log_print_condition.dart';
import '../../../models/network_call_model/api_response.dart';
import '../../../services/auth_service.dart';
import '../../../utils/resource/app_constants.dart';
import '../../dio_client/dio_client.dart';
import '../../exception/api_error_handler.dart';
import 'package:http_parser/http_parser.dart';
import '../../../models/network_call_model/store_register_response_model.dart';
import 'package:get/get.dart' as get_pack;

class StoreRegistrationRepo {
  final DioClient dioClient;
  StoreRegistrationRepo({
    required this.dioClient,
  });

  Future<StoreRegisterResponseModel> storeRegistration(
      Map<String, dynamic> storeRegistrationBody) async {
    FormData fileData = FormData.fromMap({
      "name": storeRegistrationBody["name"],
      "address": storeRegistrationBody["address"],
      "lat": storeRegistrationBody["lat"],
      "long": storeRegistrationBody["long"],
      "image": await MultipartFile.fromFile(
        storeRegistrationBody["image"].path,
        contentType: MediaType("image", "jpg"),
        filename: storeRegistrationBody["image"].path.split('/').last,
      ),
    });
    try {
      Response response =
          await dioClient.post(AppConstants.instance.storeRegistrationUrl,
              data: fileData,
              options: Options(headers: {
                'Content-Type': 'multipart/form-data',
                'authentication':
                    'Bearer ${get_pack.Get.find<AuthService>().getUserToken()}'
              }));
      StoreRegisterResponseModel model =
          StoreRegisterResponseModel.fromJson(response.data);
      model.code = 200;
      logPrint("response.data ${response.data}");
      return model;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        StoreRegisterResponseModel model =
            StoreRegisterResponseModel.fromJson(e.response!.data);
        return model;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        StoreRegisterResponseModel model = StoreRegisterResponseModel(
          //message: e.message,
          message: "Request timeout",
          code: 408,
        );
        return model;
      } else {
        StoreRegisterResponseModel model = StoreRegisterResponseModel(
          message: e.message,
          code: 400,
        );
        return model;
      }
    } on SocketException catch (e) {
      StoreRegisterResponseModel model = StoreRegisterResponseModel(
        message: e.message,
        code: 400,
      );
      return model;
    }
  }
}
