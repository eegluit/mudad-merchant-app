import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController{
  TextEditingController emailController  = TextEditingController();
  RxString emailError = "".obs;
}