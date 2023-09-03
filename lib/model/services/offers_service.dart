import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mudad_merchant/model/models/offers/create_offer_request_model.dart';
import 'package:mudad_merchant/model/models/offers/create_offer_response_model.dart';
import '../utils/resource/app_constants.dart';

class OffersService {
  Future<CreateOfferResponseModel> createOffer(
      CreateOfferRequestModel requestModel) async {
    try {
      print('ABC ${requestModel.toJson()}');
      var response = await Dio().post(
        AppConstants.instance.createOffer,
        data: requestModel.toJson(),
        options: Options(
          contentType: Headers.textPlainContentType,
          headers: {
            'x-functions-key':
                'tJeK8IYUu9V9LebykgmZsDwqts_QhW6KZzVzHCIbIfnIAzFu9p7doQ==',
            'Content-Type': 'application/json'

          },
        ),
      );
      print('ABC ${response.data}');
      CreateOfferResponseModel model =
          CreateOfferResponseModel.fromJson(response.data);
      print('ABC ${model}');
      model.code = 200;
      return model;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        CreateOfferResponseModel model =
            CreateOfferResponseModel.fromJson(e.response!.data);
        return model;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        CreateOfferResponseModel model = CreateOfferResponseModel(
          errorMessage: "Request timeout",
          code: 408,
        );
        return model;
      } else {
        CreateOfferResponseModel model = CreateOfferResponseModel(
          errorMessage: e.message,
          code: 400,
        );
        return model;
      }
    } on SocketException catch (e) {
      CreateOfferResponseModel model = CreateOfferResponseModel(
        errorMessage: e.message,
        code: 400,
      );
      return model;
    }
  }
}
