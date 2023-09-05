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
    print('ABC1 Check ${isLoading.value}');

    offersService.getOffer(userID).then((response) {
      print('ABC1 Checker ${isLoading.value}');

      if (response.code != 200) {
        isLoading.value = false;
        toastShow(error: true, massage: response.errorMessage);
      } else {
        offerList = response.result!;
        print('ABC1 $isLoading');
        isLoading.value = false;
        print('ABC2 $isLoading');

        toastShow(error: false, massage: response.successMessage);
      }
    });
  }

  // void setSelectedIndex(int index) {
  //   print('ABC12345 ${index}');

  //   selectedIndex = index;
  //   // You can perform actions based on the selected index if needed
  // }

  @override
  void onInit() {
    // Observe changes in the selected index
    print('ABC1234 ${selectedIndex}');

    // Call getOffers when the My Offers tab is selected (index 1)
    getOffers();

    super.onInit();
  }
}
