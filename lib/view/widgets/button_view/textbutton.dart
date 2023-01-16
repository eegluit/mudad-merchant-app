
import 'package:flutter/material.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';

import '../../../model/utils/resource/color_resource.dart';

Widget textBottom(String text ,VoidCallback onPressed,) {
  return GestureDetector(
      onTap: onPressed,
      child: Text(text, style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDefault, ColorResource.mainColor)));
}
Widget textBottomWithoutUnderLine(String text ,VoidCallback onPressed,) {
  return GestureDetector(
      onTap: onPressed,
      child: Text(text, style:StyleResource.instance.styleMedium(DimensionResource.fontSizeLarge, ColorResource.mainColor)));
}