import 'package:flutter/material.dart';
import 'package:flutter_derp/util/toast.dart';
import 'package:flutter_derp/page/goods/goods_page.dart';
// import 'package:flutter_derp/page/order/order_router.dart';
import 'package:flutter_derp/page/order/page/order_page.dart';
import 'package:flutter_derp/page/setting/page/setting_page.dart';
import 'package:flutter_derp/page/shop/page/shop_page.dart';
import 'package:flutter_derp/util/image_util.dart';
import 'package:flutter_derp/widgets/load_inage.dart';
import 'package:flutter_derp/page/home/provider/home_provider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _pageList;
  var _tabImages;
  var _appBarTitles = ['订单', '商品', '统计', '店铺'];
  var _pageController = PageController();

  HomeProvider provider = HomeProvider();

  List<BottomNavigationBarItem> _list;

  @override
  void initState() {
    super.initState();
    initData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _preCacheImage();
    });
  }

  _preCacheImage() {
    // 预先加载图片
    precacheImage(ImageUtils.getAssetImage("home/icon_Order_n"), context);
    precacheImage(ImageUtils.getAssetImage("home/icon_commodity_s"), context);
    precacheImage(ImageUtils.getAssetImage("home/icon_statistics_s"), context);
    precacheImage(ImageUtils.getAssetImage("home/icon_Shop_s"), context);
  }

  void initData() {
    // 页面
    _pageList = [
      OrderPage(),
      ShopPage(),
      GoodsPage(),
      SettingPage(),
    ];

    _tabImages = [
      // action icon
      [
        const LoadAssetImage("home/icon_Order_n"),
        const LoadAssetImage("home/icon_Order_s")
      ],
      [
        const LoadAssetImage("home/icon_commodity_n"),
        const LoadAssetImage("home/icon_commodity_s")
      ],
      [
        const LoadAssetImage("home/icon_statistics_n"),
        const LoadAssetImage("home/icon_statistics_s")
      ],
      [
        const LoadAssetImage("home/icon_Shop_n"),
        const LoadAssetImage("home/icon_Shop_s")
      ]
    ];

    _list = List.generate(4, (i) {
      return BottomNavigationBarItem(
          icon: _tabImages[i][0],
          activeIcon: _tabImages[i][1],
          title: Padding(
            padding: const EdgeInsets.only(top: 5.0),
            child: Text(_appBarTitles[i], key: Key(_appBarTitles[i])),
          ));
    });
  }

  DateTime _lastTime;

  Future<bool> _isExit() {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime) > Duration(microseconds: 2500)) {
      _lastTime = DateTime.now();
      Toast.show("再次点击退出应用");
      return Future.value(false);
    }
    Toast.cancelToast();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>(
      builder: (_) => provider,
      child: WillPopScope(
        onWillPop: _isExit,
        child: Scaffold(
          bottomNavigationBar: Consumer<HomeProvider>(
            builder: (_, provoider, __) {
              return BottomNavigationBar(
                backgroundColor: Colors.white,
                items: _list,
                type: BottomNavigationBarType.fixed,
                currentIndex: provider.value,
                elevation: 5.0,
                iconSize: 21.0,
                selectedFontSize: 10.0,
                unselectedFontSize: 12.0,
                selectedItemColor: Colors.black,
                unselectedItemColor: const Color(0xffbfbfbf),
                onTap: (index) {
                  _pageController.jumpToPage(index);
                },
              );
            },
          ),
          body: PageView(
              controller: _pageController,
              onPageChanged: _onPageChenged,
              children: _pageList,
              physics: NeverScrollableScrollPhysics() // 禁止滑动
              ),
        ),
      ),
    );
  }

  void _onPageChenged(int index) {
    provider.value = index;
  }
}
