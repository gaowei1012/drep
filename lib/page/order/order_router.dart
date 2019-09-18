import 'package:fluro/fluro.dart';
import 'package:flutter_derp/routers/router_init.dart';
import 'package:flutter_derp/page/order/page/order_page.dart';

class OrderRouter implements IRouterProvider {
  
  // path
  static String orderPage = "/order";
  
  @override
  void initRouter(Router router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, parmas) => OrderPage()));
  }
}