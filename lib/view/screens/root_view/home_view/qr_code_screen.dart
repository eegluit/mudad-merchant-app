import 'package:flutter/material.dart';
import 'package:mudad_merchant/view/screens/base_view/base_view_screen.dart';
import 'package:mudad_merchant/view/screens/base_view/main_view_screen.dart';
import 'package:mudad_merchant/view/widgets/view_helpers/back_button_bar_ui.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../../view_model/controllers/root_view_controller/my_offers_view_controller/create_offers_controller.dart';

class QrCodeScreen extends StatelessWidget {
  const QrCodeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: CreateOffersController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "Scan QR",),
      body: Padding(
    padding:const EdgeInsets.symmetric(horizontal: 20), 
    child:  Center(
      child: QrImageView(
        data: '1234567890',
        version: QrVersions.auto,
        size: 300.0,
      ),
    )))
   );}
 }


