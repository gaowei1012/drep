import 'package:flutter/material.dart';
import 'package:flutter_derp/util/image_util.dart';
import 'package:provider/provider.dart';
import 'package:flutter_derp/page/order/provider/order_page_provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  OrderPageProvider provider = OrderPageProvider();

  @override
  void initState() { 
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // 预加载图片
      _preCacheImage();
    });
  }

  _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage("order/xdd_n"), context);
    precacheImage(ImageUtils.getAssetImage("order/dps_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/dwc_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/ywc_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/yqx_s"), context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('order'),),
    );
  }
}
