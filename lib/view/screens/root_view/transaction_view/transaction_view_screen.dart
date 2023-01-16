import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';
import 'package:mudad_merchant/view/screens/base_view/base_view_screen.dart';

import '../../../../model/utils/resource/image_resource.dart';
import '../../../../view_model/controllers/root_view_controller/transaction_view_controller/transaction_controller.dart';
import '../../base_view/main_view_screen.dart';
class TransactionViewScreen extends StatelessWidget {
  const TransactionViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView(viewControl: TransactionController(), onPageBuilder:(context,controller)=> MainViewScreen(
      header: _buildTransactionHeader(context,controller),
      body: _buildTransactionBody(context,controller),
    ));
  }
}
Widget _buildTransactionHeader(BuildContext context ,TransactionController controller){
  return Padding(
    padding:const EdgeInsets.symmetric(horizontal: 20),
    child:Align(alignment: Alignment.centerLeft,child: Text("My Transactions ",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleOverExtraLarge, ColorResource.white),)),
  );
}

Widget _buildTransactionBody(BuildContext context ,TransactionController controller){
  return ListView(
    padding:const EdgeInsets.symmetric(horizontal: 15,vertical: 20),
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Row(
          children: [
            Text("Transaction",style: StyleResource.instance.styleSemiBold(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.textColor),),
            const Spacer(),
            _buildTransactionStatusDropdown(context,controller)
          ],
        ),
      ),
      const SizedBox(height: 20,),
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

Widget _buildTransactionStatusDropdown(BuildContext context, TransactionController controller){
  return Row(
    children: [
      const SizedBox(width: 10),
      Obx(()=>DropdownButton<String>(
        icon: const Icon(Icons.keyboard_arrow_down),
        hint: RichText(
          text: TextSpan(
              children: [
                TextSpan(
                  text: "Sort by ",
                  style: StyleResource.instance.styleRegular(DimensionResource.fontSizeLarge, ColorResource.textColor_2),
                ),
                TextSpan(
                  text: controller.selectedStatus.value,
                  style: StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.textColor),
                ),
              ]
          ),
        ),
        items: controller.statusList.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(controller.selectedStatus.value==items?"✓ $items":items,style:StyleResource.instance.styleRegular(DimensionResource.fontSizeLarge, ColorResource.textColor)),
          );
        }).toList(),
        borderRadius: BorderRadius.circular(10),
        underline:const SizedBox(),
        onChanged: (String? newValue) {
          controller.selectedStatus.value = newValue!;
        },
      ),)
    ],
  );
}