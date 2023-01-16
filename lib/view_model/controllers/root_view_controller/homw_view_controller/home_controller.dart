import 'package:get/get.dart';

class HomeController extends GetxController{

  List<String> statusList= [
    'Data',
    'Time',
    'Weekly',
    'Monthly',
    'Yearly',
  ];
  RxString selectedStatus = "Data".obs;

}

