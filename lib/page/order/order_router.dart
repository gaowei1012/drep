import 'package:fluro/fluro.dart';
import 'package:flutter_derp/routers/router_init.dart';

import 'page/order_info_page.dart';
import 'page/order_page.dart';
import 'page/order_search.dart';
import 'page/order_track_page.dart';

class OrderRouter implements IRouterProvider {
  
  // order path
  static String orderPage = "/order";
  
  @override
  void initRouter(Router router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, parmas) => OrderPage()));
  }
}
