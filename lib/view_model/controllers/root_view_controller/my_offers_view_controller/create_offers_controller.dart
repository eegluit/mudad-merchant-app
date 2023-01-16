import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';

class CreateOffersController extends GetxController{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController couponCodeController  = TextEditingController();
  TextEditingController discountController  = TextEditingController();
  TextEditingController itemsController  = TextEditingController();
  TextEditingController descriptionController  = TextEditingController();
  RxString couponCodeError = "".obs;
  RxString itemsError = "".obs;
  RxString descriptionError = "".obs;
  RxString discountError = "".obs;
  List<String> discountTypeList= [
    'Amount',
    'Percentage',
  ];
  RxString selectedDiscountType = "Amount".obs;
  Rx<DateTime> createDate = DateTime.now().obs;
  Rx<DateTime> validFromDate = DateTime.now().obs;
  Rx<DateTime> validToDate = DateTime.now().obs;

  Future<DateTime?> pickDateFormPicker()async{
    DateTime ?currentDate ;
    await showDatePicker(
        context: Get.context!,
        initialDate: createDate.value,
        initialDatePickerMode: DatePickerMode.day,
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme:const  ColorScheme.light(
                primary: ColorResource.mainColor, // <-- SEE HERE
                onPrimary: ColorResource.white, // <-- SEE HERE
                onSurface: ColorResource.mainColor, // <-- SEE HERE
              ),
              textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                  primary: ColorResource.textColor, // button text color
                ),
              ),
            ),
            child: child!,
          );
        },
        firstDate: DateTime.now().subtract(const Duration(days: 15)),
        lastDate: DateTime.now()).then((value){
      if(value!=null){
        currentDate = value.add(Duration(hours: DateTime.now().hour,minutes: DateTime.now().minute,seconds: DateTime.now().second));
      }
    });
    return currentDate;
  }
}