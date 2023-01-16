import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/image_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';

import '../../../model/utils/resource/color_resource.dart';
import '../button_view/common_button.dart';


class NoDataFoundScreen extends StatelessWidget {
  final String ?message;
  final VoidCallback ?onRefresh;
  final bool showRefreshButton;
  const NoDataFoundScreen({Key? key, this.message, this.onRefresh,this.showRefreshButton = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResource.white,
      body: SizedBox(
        height: double.infinity,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageResource.instance.noDataFoundImage),
              const SizedBox(height: 20,),
              Text(
                message ?? "No data available!".tr,
                style: StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.textColor_2),textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Visibility(visible: showRefreshButton,child: CommonButton(onPressed: onRefresh??(){},text: "Refresh",color: ColorResource.textColor,loading: false,)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
