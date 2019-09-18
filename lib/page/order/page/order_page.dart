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
    return ChangeNotifierProvider<OrderPageProvider>(
      builder: (_) => provider,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            const SafeArea(
              child: const SizedBox(
                height: 105,
                width: double.infinity,
                child: const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: const [Color(0xFF5793FA), Color(0xFF4647FA)])
                  ),
                ),
              ),
            ),
            NestedScrollView(
              key: const Key('order_list'),
              physics: ClampingScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return _sliverBuilder(context);
              },
              body: PageView.builder(
                key: const Key('pageView'),
                itemCount: 5,
                onPageChanged: _onPageChange,
                controller: _pageController,
                itemBuilder: (_, index) {
                  return OrderList(index: index);
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Gaps.empty,
          actions: <Widget>[
            IconButton(
              onPressed: () {
                // 这里是搜索页面导航
                NavigatorUtils.push(context, OrderRouter.orderPage);
              },
              tooltip: '搜索',
              icon: const LoadAssetImage("order/icon_search", width: 22.0, height: 22.0),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: true,
          expandedHeight: 100.0,
          floating: false,// 不随着滚动隐藏标题
          pinned: true,// 固定在顶部
          //flexibleSpace: ,
        ),
      ),
      SliverPersistentHeader(
        pinned: true,
        delegate: SliverAppBarDelegate(
          DecoratedBox(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: ImageUtils.getAssetImage("order/order_bg1"),
                fit: BoxFit.fill
              )
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MyCard(),
            ),
          )
        ),
      )
    ];
  } 

  PageController _pageController = PageController(initialPage: 0);
  _onPageChange(int index) async {
    provider.setIndex(index);
    _tabController.animateTo(index);
  }
}


class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;

  SliverAppBarDelegate(this.widget, this.height);

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override 
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}