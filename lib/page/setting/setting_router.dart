import 'package:fluro/fluro.dart';
import 'package:flutter_derp/routers/router_init.dart';

import 'page/setting_page.dart';

class SettingRouter implements IRouterProvider {
  static String settingPage = '/setting';

  @override
  void initRouter(Router router) {
    router.define(settingPage, handler: Handler(handlerFunc: (_, params) => SettingPage()));
  }
}