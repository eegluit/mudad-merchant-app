import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../utils/resource/app_constants.dart';
import '../api_helper/network_info.dart';
import '../api_helper/provider_helper/auth_provider.dart';
import '../api_helper/provider_helper/kyc_provider.dart';
import '../api_helper/provider_helper/profile_provider.dart';
import '../api_helper/provider_helper/store_registration_provider.dart';
import '../api_helper/repository_helper/auth_repo.dart';
import '../api_helper/repository_helper/kyc_repo.dart';
import '../api_helper/repository_helper/profile_repo.dart';
import '../api_helper/repository_helper/store_registration_repo.dart';
import 'dio_client.dart';
import 'logging_interceptor.dart';


GetIt getIt = GetIt.instance;

Future<void> getInit() async {
  /// Core
  getIt.registerLazySingleton(() => NetworkInfo(getIt()));
  getIt.registerLazySingleton(() => DioClient(AppConstants.instance.baseUrl, getIt(), loggingInterceptor: getIt(),));

  /// External
  getIt.registerLazySingleton(() => Dio());
  getIt.registerLazySingleton(() => LoggingInterceptor());
  getIt.registerLazySingleton(() => Connectivity());

  /// Repository
  getIt.registerLazySingleton(() => AuthRepo(dioClient: getIt(),));
  getIt.registerLazySingleton(() => KycRepo(dioClient: getIt(),));
  getIt.registerLazySingleton(() => StoreRegistrationRepo(dioClient: getIt(),));
  getIt.registerLazySingleton(() => ProfileRepo(dioClient: getIt(),));


  /// Provider
  getIt.registerFactory(() => AuthProvider(authRepo: getIt()));
  getIt.registerFactory(() => KycProvider(kycRepo: getIt()));
  getIt.registerFactory(() => StoreRegistrationProvider(storeRegistrationRepo: getIt()));
  getIt.registerFactory(() => ProfileProvider(profileRepo: getIt()));




}