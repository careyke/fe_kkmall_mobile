import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
import './category_page.dart';
import './home_page.dart';
import './membership.dart';
import './shopping_cart_page.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
  final List<BottomNavigationBarItem> bottomNavigationItems=[
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('首页')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.search),
      title: Text('分类')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      title: Text('购物车')
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.account_circle),
      title: Text('个人中心')
    )
  ];

  void _switchTab(index){
    setState(() {
      activePageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //假设设计稿是以iphone6为原型
    ScreenUtil.instance = ScreenUtil(
      width: 750,
      height: 1334,
      allowFontScaling: true
    )..init(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: bottomNavigationItems,
        currentIndex: activePageIndex,
        onTap: _switchTab,
      ),
      body: tabPages[activePageIndex],
    );
  }
}
