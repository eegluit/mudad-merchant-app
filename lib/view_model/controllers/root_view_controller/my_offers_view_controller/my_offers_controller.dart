import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/models/offers/get_offer_response_model.dart';
import 'package:mudad_merchant/model/services/auth_service.dart';
import 'package:mudad_merchant/model/services/offers_service.dart';
import 'package:mudad_merchant/view/widgets/toast_view/showtoast.dart';

class MyOffersController extends GetxController {
  List<OfferResponseModel> offerList = [];
  var offersService = OffersService();
  var userID = Get.find<AuthService>().getUserID();
  RxBool isLoading = true.obs;
  int selectedIndex = 0;

  Future getOffers() async {
    isLoading.value = true;

    offersService.getOffer(userID).then((response) {
      if (response.code != 200) {
        isLoading.value = false;
        toastShow(error: true, massage: response.errorMessage);
      } else {
        offerList = response.result!;
        isLoading.value = false;
        toastShow(error: false, massage: response.successMessage);
      }
    });
  }

  @override
  void onInit() {
    getOffers();

    super.onInit();
  }
}
