import 'package:flutter/material.dart';
import 'package:flutter_derp/page/order/order_router.dart';
import 'package:flutter_derp/util/image_util.dart';
import 'package:flutter_derp/widgets/load_inage.dart';
import 'package:provider/provider.dart';
import 'package:flutter_derp/page/order/provider/order_page_provider.dart';
import 'package:flutter_derp/widgets/my_flexible_space.dart';
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
              headerSliverBuilder: (context, innerBosScrolled) {
                return _sliverBuilder(context);
              },
              body: PageView.builder(
                key: const Key('page_view'),
                itemCount: 5,
                onPageChanged: null,
                controller: null,
                itemBuilder: (_, index) {
                  return null;
                },
              ),
            )
          ],
        )
      ),
    );
  }
}

List<Widget> _sliverBuilder(BuildContext context) {
  return <Widget>[
    SliverOverlapAbsorber(
      handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
      child: SliverAppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
            onPressed: () {
              NavigatorUtils.push(context, null);
            },
            tooltip: '搜索',
            icon: const LoadAssetImage('order/icon_search', width: 22.0, height: 22.0),
          )
        ],
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        centerTitle: true,
        expandedHeight: 100.0,
        floating: false, // 不随着标题滚动而滚动
        pinned: true, // 固定在顶部
        flexibleSpace: const MyFlexibleSpaceBar(
          background: const LoadAssetImage("order/order_bg", width: double.infinity, height: 11.3, fit: BoxFit.fill),
          centerTitle: true,
          titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
          collapseMode: CollapseMode.pin,
          title: const Text("订单"),
        )
      ),
    ),
    // SliverPersistentHeader(
    //   pinned: true,
    //   delegate: SliverAppBarDelegate(
    //     DecoratedBox(
    //       decoration: BoxDecoration(
    //         image: DecorationImage(
    //           image: ImageUtils.getAssetImage("order/order_bg1"),
    //           fit: BoxFit.fill
    //         )
    //       ),
          // child: Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Container(
          //     child: Center(
          //       child: Text("this is my card"),
          //     ),
          //   ),
          // ),
        // )
        // , 80.0
      // ),
    // )
  ];
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
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