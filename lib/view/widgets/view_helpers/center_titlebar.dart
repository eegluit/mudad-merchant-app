import 'package:flutter/material.dart';

import '../../../model/utils/resource/color_resource.dart';
import '../../../model/utils/resource/dimensions_resource.dart';
import '../../../model/utils/resource/style_resource.dart';


class TitleBarCenter extends StatelessWidget {
   final String? titleText;
   final Color? titleColor;
   final double? textSize;


   const TitleBarCenter({Key? key,this.titleText,this.titleColor,this.textSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText??'',
      style: StyleResource.instance.styleMedium(
          textSize?? DimensionResource.fontSizeExtraLarge,
          titleColor?? ColorResource.white),
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
    );
  }
}
