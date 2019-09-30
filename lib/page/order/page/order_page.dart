import 'package:flutter/material.dart';
import 'package:flutter_derp/page/order/order_router.dart';
import 'package:flutter_derp/util/image_util.dart';
import 'package:flutter_derp/widgets/load_inage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_derp/page/order/provider/order_page_provider.dart';
import 'package:flutter_derp/routers/fluro_navigator.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with AutomaticKeepAliveClientMixin<OrderPage>, SingleTickerProviderStateMixin {


  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  OrderPageProvider provider = OrderPageProvider();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('this is order page'),
    );
  }
}