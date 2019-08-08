/**
 * 下拉刷新和上拉加载的组件
 * 本质上是使用CustomScrollView+Sliders+ScrollNatification
 * 使用flutter_easyrefresh
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fe_kkmall_mobile/widgets/refresh_load/refresh_store.dart';
import 'package:fe_kkmall_mobile/widgets/refresh_load/refresh_header.dart';
import 'package:fe_kkmall_mobile/services/methods.dart';

class RefreshLoadWidget extends StatefulWidget {
  RefreshLoadWidget({Key key, this.children}) : super(key: key);

  final List<Widget> children;

  @override
  RefreshLoadWidgetState createState() => RefreshLoadWidgetState();
}

class RefreshLoadWidgetState extends State<RefreshLoadWidget> {
  Map store;

  @override
  void initState() {
    super.initState();
    store = Map();
  }

  @override
  Widget build(BuildContext context) {
    return (RefreshStore(
      state: store,
      child: EasyRefresh(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 2), () {
            setState(() {});
          });
          // await getHomePageCarousel();
          // setState(() {
            
          // });
        },
        header: RefreshHeader(),
        child: ListView.builder(
            itemExtent: 40.0,
            itemCount: 20,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 40.0,
                color: index % 2 == 0 ? Colors.green : Colors.red,
                child: Text(index.toString()),
              );
            }),
      ),
    ));
  }
}
