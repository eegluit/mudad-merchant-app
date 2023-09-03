import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../view/widgets/log_print/log_print_condition.dart';
import '../../view_model/routes/app_pages.dart';
import '../models/user_model/user_model.dart';
import '../network_calls/dio_client/dio_client.dart';
import '../network_calls/dio_client/get_it_instance.dart';
import '../utils/resource/string_resource.dart';

class AuthService extends GetxService {
  Rx<User> user = User().obs;
  GetStorage? box;
  RxString firebaseToken = "".obs;

  Future<AuthService> init() async {
    box = GetStorage();
    getCurrentUserData();
    return this;
  }

  saveUser(Map<String, dynamic> map) async {
    await box!.write(StringResource.instance.currentUser, map);
    user.value = User.fromJson(map);
    getCurrentUserData();
  }

  Future saveUserId(String userID) async {
    try {
      await box!.write(StringResource.instance.userID, userID);
    } catch (e) {
      rethrow;
    }
  }

  getCurrentUserData() async {
    if (box!.hasData(StringResource.instance.currentUser)) {
      logPrint(
          "user data box =>${box!.read(StringResource.instance.currentUser)}");
      try {
        user.value =
            User.fromJson(box!.read(StringResource.instance.currentUser));
        logPrint(user.value.name);
      } catch (e) {
        logPrint("User Data Error =>$e");
      }
    } else {
      user.value = User();
    }
  }

  Future<void> saveUserToken(String token) async {
    try {
      await box!.write(StringResource.instance.token, token);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> removeUserData() async {
    user.value = User();
    await box!.remove(StringResource.instance.currentUser);
  }

  Future<void> removeToken() async {
    await box!.remove(StringResource.instance.token);
  }

  Future<void> removeIsRemember() async {
    await box!.remove(StringResource.instance.remember);
  }

  Future<void> logOut() async {
    await removeUserData();
    await removeToken();
    await removeIsRemember();
    DioClient dio = getIt();
    dio.dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer '
    };
    Get.offAllNamed(Routes.loginScreen);
  }

  String getUserID() {
    return box!.read(StringResource.instance.userID) ?? "";
  }

  String getUserToken() {
    return box!.read(StringResource.instance.token) ?? "";
  }

  bool get isFirst => box!.read(StringResource.instance.isFirst) ?? false;
  bool get isLogin => box!.hasData(StringResource.instance.currentUser);
  bool get isPermission => box!.hasData(StringResource.instance.isPermission);
}
