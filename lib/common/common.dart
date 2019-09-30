import 'package:flutter/material.dart';

class Contant {
  static const bool inProduction = const bool.fromEnvironment("dart.vm.product");

  static bool isTest = false;

  static const String data = 'data';
  static const String message = 'message';
  static const String code = 'code';

  static const String key_guide = 'key_guide';
  static const String phone = 'phone';

}
