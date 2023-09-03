import 'package:get/get.dart';
import 'package:mudad_merchant/model/services/auth_service.dart';

class HomeController extends GetxController{

  List<String> statusList= [
    'Data',
    'Time',
    'Weekly',
    'Monthly',
    'Yearly',
  ];
  RxString selectedStatus = "Data".obs;
  var token = Get.find<AuthService>().getUserToken();
  var userID = Get.find<AuthService>().getUserID();

}

