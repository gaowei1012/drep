import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'application.dart';
import 'routers.dart';

// 路由跳转工具类
class NavigatorUtils {
  
  // push path
  static push(BuildContext context, String path, {bool replace = false, bool clearStack = false}) {
    // 逝去焦点
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack);
  }

  static pushRouter(BuildContext context, String path, Function(Object) function, {bool replace: false, bool clearStack = false}) {
    FocusScope.of(context).unfocus();
    Application.router.navigateTo(context, path, replace: replace, clearStack: clearStack, transition: TransitionType.native).then((result) {
      if (result == null) {
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

/// 返回
  static void getBack(BuildContext context) {
    FocusScope.of(context).unfocus();
    Navigator.pop(context);
  }

  //static goWebViewPage(BuildContext context, String title, String url) {
  //  push(context, '${Routes.webViewPage}?title=${Uri.encodeComponent(title)}&url=${Uri.encodeComponent(url)}');
  //}
}
