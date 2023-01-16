


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../model/utils/resource/image_resource.dart';
import '../../../view/screens/root_view/home_view/home_view_screen.dart';
import '../../../view/screens/root_view/my_offers_view/my_offers_view.dart';
import '../../../view/screens/root_view/profile_view/profile_screen.dart';
import '../../../view/screens/root_view/transaction_view/transaction_view_screen.dart';
import '../../../view/widgets/log_print/log_print_condition.dart';

class RootViewController extends GetxController{
  final GlobalKey<ScaffoldState> scaffoldKey =  GlobalKey<ScaffoldState>();
  RxInt selectedIndex = 0.obs;
  List<Widget> widgetOptions = <Widget>[
    const HomeViewScreen(),
    const MyOffersScreen(),
    const TransactionViewScreen(),
    const ProfileScreen(),
  ];

  List<Map<String,dynamic>> bottomBarList = [
  {"image":ImageResource.instance.homeIcon,"title":"Home"},
  {"image":ImageResource.instance.myOffersIcon,"title":"My Offers"},
  {"image":ImageResource.instance.transactionIcon,"title":"Transaction"},
  {"image":ImageResource.instance.accountIcon,"title":"Profile"},
  ];

  onItemTapped(int index) {
    selectedIndex.value = index;
    logPrint(selectedIndex.value);
  }




  @override
  void onInit() {
    if(Get.arguments!=null ){
      Map<String,dynamic> backData=Get.arguments;
      if(backData.containsKey("pageIndex")){
        onItemTapped(backData["pageIndex"]);
      }
    }
    super.onInit();
  }
}


