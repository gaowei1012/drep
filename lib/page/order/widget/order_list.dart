  

import 'package:flutter/material.dart';
import 'package:flutter_derp/page/order/provider/order_page_provider.dart';
import 'package:flutter_derp/page/order/widget/order_item.dart';
import 'package:flutter_derp/page/order/widget/order_item_tag.dart';
import 'package:flutter_derp/widgets/my_flexible_space.dart';
import 'package:flutter_derp/widgets/state_layout.dart';
import 'package:provider/provider.dart';


class OrderList extends StatefulWidget {

  final int index;

  OrderList({
      Key key,
      @required this.index
    }):super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {

  bool _isLoading = false;
  int _page = 1;
  // final int _stateType = StateType.loading;
  int _index = 0;
  ScrollController _controller = ScrollController();

  @override
  void initState() { 
    super.initState();
    _index = widget.index;
    _onRefresh();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return NotificationListener(
      onNotification: (ScrollNotification note) {
        if (note.metrics.pixels == note.metrics.maxScrollExtent) {
          //_loadMore();
        }
        return true;
      },
      child: RefreshIndicator(
        onRefresh: _onRefresh,
      ),
    );
  }
}

List _list = [];

Future _onRefresh() async {
  // todo
}


bool _hasMore() {
  // todo
}

Future _loadMore() async {
  // todo
}