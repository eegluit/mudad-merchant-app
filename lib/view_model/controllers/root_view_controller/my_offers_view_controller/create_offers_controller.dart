import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/services/auth_service.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/services/offers_service.dart';

class CreateOffersController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  var offersService = OffersService();
  var userID = Get.find<AuthService>().getUserID();
  TextEditingController couponCodeController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController itemsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  RxBool isLoading = false.obs;
  RxString offerId = "".obs;
  RxString couponCodeError = "".obs;
  RxString itemsError = "".obs;
  RxString descriptionError = "".obs;
  RxString discountError = "".obs;
  List<String> discountTypeList = [
    'Amount',
    'Percentage',
  ];
  RxString selectedDiscountType = "Amount".obs;
  Rx<DateTime> createDate = DateTime.now().obs;
  Rx<DateTime> validFromDate = DateTime.now().obs;
  Rx<DateTime> validToDate = DateTime.now().obs;

  @override
  void onInit() {
    if (Get.arguments != null) {
      couponCodeController.text = Get.arguments[0];
      discountController.text = Get.arguments[1].toString();
      itemsController.text = Get.arguments[5].toString();
      selectedDiscountType.value = Get.arguments[2].toString();
      descriptionController.text = Get.arguments[6];
      validFromDate.value = DateTime.parse(Get.arguments[3].toString());
      validToDate.value = DateTime.parse(Get.arguments[4].toString());
      offerId.value = Get.arguments[7];
    }
    super.onInit();
  }

  Future<DateTime?> pickDateFormPicker() async {
    DateTime? currentDate;
    await showDatePicker(
            context: Get.context!,
            initialDate: createDate.value,
            initialDatePickerMode: DatePickerMode.day,
            builder: (context, child) {
              return Theme(
                data: Theme.of(context).copyWith(
                  colorScheme: const ColorScheme.light(
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
            lastDate: DateTime.now())
        .then((value) {
      if (value != null) {
        currentDate = value.add(Duration(
            hours: DateTime.now().hour,
            minutes: DateTime.now().minute,
            seconds: DateTime.now().second));
      }
    });
    return currentDate;
  }
}
