import 'package:flutter/material.dart';
import 'package:flutter_derp/page/order/provider/order_page_provider.dart';
import 'package:flutter_derp/page/order/widget/order_item.dart';
import 'package:flutter_derp/page/order/widget/order_item_tag.dart';
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("this is order list"),
    );
  }
}
