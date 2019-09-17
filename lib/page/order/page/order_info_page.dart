import 'package:flutter/material.dart';
import 'package:flutter_derp/util/image_util.dart';
import 'package:provider/provider.dart';

class OrderInfoPage extends StatefulWidget {
  @override
  _OrderInfoPageState createState() => _OrderInfoPageState();
}

class _OrderInfoPageState extends State<OrderInfoPage> {

  OrderPageProvider provider = OrderPageProvider()  

  @override
  void initState() { 
    super.initState();
    // widget binding instance
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCacheImage();
    });
  }

  // 预先加载image
  _preCacheImage() {
    precacheImage(ImageUtils.getAssetImage("order/xdd_n"), context);
    precacheImage(ImageUtils.getAssetImage("order/dps_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/dwc_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/ywc_s"), context);
    precacheImage(ImageUtils.getAssetImage("order/yqx_s"), context);
  } 


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('order info'),
    );
  }
}
