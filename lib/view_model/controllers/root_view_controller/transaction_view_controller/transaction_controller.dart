import 'package:get/get.dart';

class TransactionController extends GetxController{
  List<String> statusList= [
    'Data',
    'Time',
    'Weekly',
    'Monthly',
    'Yearly',
  ];
  RxString selectedStatus = "Data".obs;
}