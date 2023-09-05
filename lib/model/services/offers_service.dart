import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mudad_merchant/model/models/offers/create_offer_request_model.dart';
import 'package:mudad_merchant/model/models/offers/create_offer_response_model.dart';
import 'package:mudad_merchant/model/models/offers/delete_offer_response_model.dart';
import 'package:mudad_merchant/model/models/offers/get_offer_response_model.dart';
import '../utils/resource/app_constants.dart';

class OffersService {
  Future<CreateOfferResponseModel> createOffer(
      CreateOfferRequestModel requestModel) async {
    try {
      print('ABC ${requestModel.toJson()}');
      var response = await Dio().post(
        '${AppConstants.instance.createOffer}${requestModel.UserId}',
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
      CreateOfferResponseModel model =
          CreateOfferResponseModel.fromJson(response.data);
      print('ABC ${response}');
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

  Future<DeleteOfferResponseModel> deleteOffer(String offerId) async {
    try {
      print('ABC ${offerId}');

      var response = await Dio().delete(
        '${AppConstants.instance.getOffer}$offerId',
        options: Options(
          headers: {
            'x-functions-key':
                'tJeK8IYUu9V9LebykgmZsDwqts_QhW6KZzVzHCIbIfnIAzFu9p7doQ==',
          },
        ),
      );
      print('ABC ${response}');
      DeleteOfferResponseModel model =
          DeleteOfferResponseModel.fromJson(response.data);
      model.code = response.statusCode;
      print('ABC ${model}');
      return model;
    } on DioError catch (e) {
      print('ABC ${e}');

      if (e.type == DioErrorType.response) {
        DeleteOfferResponseModel model =
            DeleteOfferResponseModel.fromJson(e.response!.data);
        model.code = e.response!.statusCode;
        return model;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        DeleteOfferResponseModel model = DeleteOfferResponseModel(
          errorMessage: e.message,
          code: 408,
        );
        return model;
      } else {
        DeleteOfferResponseModel model = DeleteOfferResponseModel(
          errorMessage: e.message,
          code: 400,
        );
        return model;
      }
    } on SocketException catch (e) {
      DeleteOfferResponseModel model = DeleteOfferResponseModel(
        errorMessage: e.message,
        code: 400,
      );
      return model;
    }
  }

  Future<DeleteOfferResponseModel> updateOffer(
      String offerId, CreateOfferRequestModel requestModel) async {
        try {
      print('ABC ${requestModel.toJson()}');
      var response = await Dio().put(
        '${AppConstants.instance.createOffer}${offerId}',
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
      DeleteOfferResponseModel model =
          DeleteOfferResponseModel.fromJson(response.data);
      print('ABC ${response}');
      model.code = 200;
      return model;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        DeleteOfferResponseModel model =
            DeleteOfferResponseModel.fromJson(e.response!.data);
        return model;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        DeleteOfferResponseModel model = DeleteOfferResponseModel(
          errorMessage: "Request timeout",
          code: 408,
        );
        return model;
      } else {
        DeleteOfferResponseModel model = DeleteOfferResponseModel(
          errorMessage: e.message,
          code: 400,
        );
        return model;
      }
    } on SocketException catch (e) {
      DeleteOfferResponseModel model = DeleteOfferResponseModel(
        errorMessage: e.message,
        code: 400,
      );
      return model;
    }

    }

  Future<GetOfferResponseModel> getOffer(String userId) async {
    try {
      var response = await Dio().get(
        '${AppConstants.instance.getOffer}$userId',
        options: Options(
          contentType: Headers.textPlainContentType,
          headers: {
            'x-functions-key':
                'tJeK8IYUu9V9LebykgmZsDwqts_QhW6KZzVzHCIbIfnIAzFu9p7doQ==',
            'Content-Type': 'application/json'
          },
        ),
      );
      print('ABC123 ${response.data}');

      GetOfferResponseModel model =
          GetOfferResponseModel.fromJson(response.data);
      model.code = response.statusCode;
      print('ABC1 ${model}');
      return model;
    } on DioError catch (e) {
      if (e.type == DioErrorType.response) {
        GetOfferResponseModel model =
            GetOfferResponseModel.fromJson(e.response!.data);
        model.code = e.response!.statusCode;
        return model;
      } else if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        GetOfferResponseModel model = GetOfferResponseModel(
          errorMessage: e.message,
          code: 408,
        );
        return model;
      } else {
        GetOfferResponseModel model = GetOfferResponseModel(
          errorMessage: e.message,
          code: 400,
        );
        return model;
      }
    } on SocketException catch (e) {
      GetOfferResponseModel model = GetOfferResponseModel(
        errorMessage: e.message,
        code: 400,
      );
      return model;
    }
  }
}
