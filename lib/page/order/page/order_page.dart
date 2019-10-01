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
  void initState() { 
    super.initState();
    // tab viwe 
    _tabController = TabController(vsync: this, length: 5);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCacheImage();
    });
  }

  // 图片缓存
  _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage("order/xdd_n"), context);
    precacheImage(ImageUtils.getAssetImage("order/dps_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/dwc_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/ywc_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/yqx_s"), context);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ChangeNotifierProvider<OrderPageProvider>(
      builder: (_) => provider,
      child: Scaffold(
        body: Center(
          child: Text("this is order"),
        ),
      ),
    );
  }
}