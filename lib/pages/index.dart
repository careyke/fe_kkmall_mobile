import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import './category_page.dart';
import './home_page.dart';
import './membership.dart';
import './shopping_cart_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fe_kkmall_mobile/iconfonts.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key}) : super(key: key);

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  int activePageIndex = 0;
  final List<Widget> tabPages = [
    HomePage(),
    Category(),
    ShoppingCart(),
    Membership()
  ];
  final List<BottomNavigationBarItem> bottomNavigationItems = [
    BottomNavigationBarItem(icon: Icon(Iconfonts.home), title: Text('首页')),
    BottomNavigationBarItem(icon: Icon(Iconfonts.search), title: Text('分类')),
    BottomNavigationBarItem(
        icon: Icon(Iconfonts.cert), title: Text('购物车')),
    BottomNavigationBarItem(
        icon: Icon(Iconfonts.account), title: Text('个人中心'))
  ];

  void _switchTab(index) {
    setState(() {
      activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //假设设计稿是以iphone6为原型,尺寸是dpi
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
          ..init(context);
    return Scaffold(
      // appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationItems,
        currentIndex: activePageIndex,
        onTap: _switchTab,
        unselectedFontSize: 9.0,
        selectedFontSize: 10.0,
        iconSize: 18.0,
      ),
      body: tabPages[activePageIndex],
    );
  }
}
