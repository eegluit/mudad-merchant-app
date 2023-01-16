import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mudad_merchant/model/utils/resource/color_resource.dart';
import 'package:mudad_merchant/model/utils/resource/dimensions_resource.dart';
import 'package:mudad_merchant/model/utils/resource/style_resource.dart';
import 'package:mudad_merchant/view/widgets/log_print/log_print_condition.dart';

class CommonTextField extends StatelessWidget {
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextCapitalization? textCapitalization;
  final Function(String)? onFieldSubmitted;
  final String? initialValue;
  final String? hintText;
  final String? errorText;
  final String? iconData;
  final bool? obscureText;
  final Widget? prefixIcon;
  final bool? readOnly;
  final bool? showShadow;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final Color? containerColor;
  final Color? cursorColor;
  final Color? outLineColor;
  final Color? hintColor;
  final Color? errorColor;
  final int? maxLength;
  final bool? suffixIcon;
  final Widget? suffixIconWidget;
  final Function(String)? onValueChanged;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final String? label;
  final Widget? trailWidget;
  CommonTextField({
    Key? key,
    this.validator,
    this.keyboardType,
    this.textInputAction,
    this.textCapitalization,
    this.onFieldSubmitted,
    this.initialValue,
    this.hintText,
    this.errorText,
    this.showShadow,
    this.iconData,
    this.obscureText,
    this.prefixIcon,
    this.inputFormatters,
    this.controller,
    this.containerColor,
    this.cursorColor,
    this.outLineColor,
    this.hintColor,
    this.errorColor,
    this.maxLength,
    this.suffixIconWidget,
    this.onValueChanged,
    this.style,
    this.hintStyle,
    this.label,
    this.trailWidget,
    this.readOnly,
    this.suffixIcon,
  }) : super(key: key);
  RxBool passwordVisible = true.obs;
  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: label != null ? true : false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label ?? "",
                style: StyleResource.instance.styleMedium(DimensionResource.fontSizeDoubleExtraLarge, ColorResource.secondColor),
                textAlign: TextAlign.start,
              ),
              trailWidget ?? const SizedBox()
            ],
          ),
        ),
        Visibility(
            visible: label != null ? true : false,
            child: const SizedBox(
              height: 8,
            )),
        Container(
          height: 50,
          decoration: const BoxDecoration(
              color: ColorResource.white,
              border: Border(
                bottom: BorderSide(
                    color: ColorResource.borderTextField2, width: 1.5),
              )),
          child: Obx(() {
            logPrint(passwordVisible.value);
            return TextFormField(
              controller: controller,
              obscuringCharacter: '●',
              readOnly: readOnly ?? false,
              inputFormatters: inputFormatters,
              textInputAction: textInputAction??TextInputAction.next,
              keyboardType: keyboardType,
              maxLength: maxLength,
              onChanged: onValueChanged,
              obscureText: suffixIcon == true ? passwordVisible.value : false,
              cursorColor: ColorResource.mainColor,
              style: StyleResource.instance.styleRegular(DimensionResource.fontSizeExtraLarge, ColorResource.textColor),
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  hintText: hintText,
                  counterText: "",
                  hintStyle: StyleResource.instance.styleRegular(DimensionResource.fontSizeExtraLarge, ColorResource.textColor_2),
                  border: InputBorder.none,
                  suffixIcon: suffixIcon == true
                      ? IconButton(
                          icon: Icon(
                            passwordVisible.value ? Icons.visibility_off : Icons.visibility,
                            color: passwordVisible.value ? ColorResource.borderTextField2 : ColorResource.mainColor,
                            size: 25,
                          ),
                          onPressed: () {
                            passwordVisible.value = !passwordVisible.value;
                          },
                        )
                      : suffixIconWidget == null
                          ? const SizedBox()
                          : suffixIconWidget!,
                  errorText: "",
                  errorStyle: const TextStyle(
                    height: 0,
                  )),
              validator: validator,
            );
          }),
        ),
        errorText == null || errorText == ""
            ? const SizedBox()
            : Padding(
                padding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                child: Text(
                  errorText!,
                  style: StyleResource.instance.styleRegular(DimensionResource.fontSizeSmall, ColorResource.errorColor),
                  textAlign: TextAlign.start,
                ),
              ),
      ],
    );
  }
}
