import 'package:flutter/material.dart';

import '../../../../../model/utils/resource/color_resource.dart';
import '../../../../../model/utils/resource/dimensions_resource.dart';
import '../../../../../model/utils/resource/image_resource.dart';
import '../../../../../model/utils/resource/style_resource.dart';
import '../../../../../view_model/controllers/root_view_controller/transaction_view_controller/view_all_transaction_controller.dart';
import '../../../../widgets/view_helpers/back_button_bar_ui.dart';
import '../../../base_view/base_view_screen.dart';
import '../../../base_view/main_view_screen.dart';
class ViewAllTransactionScreen extends StatelessWidget {
  const ViewAllTransactionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: ViewAllTransactionController(), onPageBuilder:(context,controller)=> MainViewScreen(
      isBottomBarAvailable: false,
      header:const BackButtonBarUi(title: "All Transactions",),
      body: _buildViewAllTransactionBody(context,controller),
    ));
  }
}


Widget _buildViewAllTransactionBody(BuildContext context ,ViewAllTransactionController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    children: [
      ...List.generate(10, (index) => _buildTransactionRowUi(
          backGroundColor: index.isOdd?ColorResource.transactionColor:ColorResource.white,
          transactionDateAndTime: "March 12, 06:30 pm",
          amount: "+RO 100",
          transactionTitle: "Recived from Customer "
      ))
    ],
  );
}

Widget _buildTransactionRowUi({required Color backGroundColor,required String transactionTitle,required  String transactionDateAndTime,required String amount}){
  return Container(
    margin:const EdgeInsets.only(bottom: 10),
    padding:const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: backGroundColor,
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 50,
          width: 50,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: ColorResource.secondColor,
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(ImageResource.instance.walletIcon,color: ColorResource.white,),
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(transactionTitle,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeExtraLarge, ColorResource.black),),
              const SizedBox(height: 5,),
              Text(transactionDateAndTime,style: StyleResource.instance.styleRegular(DimensionResource.fontSizeDefault, ColorResource.textColor),),

            ],
          ),
        ),
        const SizedBox(width: 10,),
        Text(amount,style: StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.darkGreenColor),),


      ],
    ),

  );
}

