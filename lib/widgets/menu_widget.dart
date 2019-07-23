import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fe_kkmall_mobile/constants/homepage_menus.dart';

final List<_MenuItem> _menuItems = homepage_menu_data.map((item) {
  return _MenuItem(
    url: item['url'],
    text: item['text'],
  );
}).toList();

class MenuWidget extends StatelessWidget {
  MenuWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil.getInstance().setHeight(300.0),
        color: Color(0xffffffff),
        child: _GridMenu());
  }
}

class _GridMenu extends StatefulWidget {
  _GridMenu({Key key}) : super(key: key);

  @override
  _GridMenuState createState() => _GridMenuState();
}

class _GridMenuState extends State<_GridMenu> {
  double _scrollRate = 0.0; //滚动的比率
  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      setState(() {
        _scrollRate = _scrollController.offset /
            _scrollController.position.maxScrollExtent;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        GridView.count(
          scrollDirection: Axis.horizontal,
          crossAxisCount: 2,
          padding: EdgeInsets.all(0.0),
          childAspectRatio: ScreenUtil.getInstance().scaleHeight /
              ScreenUtil.getInstance().scaleWidth,
          controller: _scrollController,
          children: _menuItems,
        ),
        _CustomScrollBar(_scrollRate)
      ],
    );
  }
}

class _CustomScrollBar extends StatelessWidget {
  _CustomScrollBar(this.scrollRate,
      {Key key,
      this.scrollBarWidth = 30.0,
      this.sliderWidth = 10.0,
      this.scrollBarHeight = 3.0})
      : super(key: key);
  final double scrollRate;
  final double scrollBarWidth;
  final double sliderWidth;
  final double scrollBarHeight;

  double _getLeft() => (scrollBarWidth - sliderWidth) * scrollRate;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 3.0,
        child: Container(
          width: scrollBarWidth,
          height: scrollBarHeight,
          color: Color(0xffd8e2dc),
          child: RepaintBoundary( //重绘边界
            child: Stack(
              alignment: Alignment.centerLeft,
              children: <Widget>[
                Positioned(
                  left: _getLeft(),
                  child: Container(
                    height: scrollBarHeight,
                    width: sliderWidth,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            )
          ),
        ));
  }
}

class _MenuItem extends StatelessWidget {
  _MenuItem({Key key, this.url, this.text}) : super(key: key);
  final String url;
  final String text;

  void _categoryClick() {
    print('click $text');
  }

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: _categoryClick,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            url,
            width: ScreenUtil.getInstance().setWidth(95.0),
            height: ScreenUtil.getInstance().setHeight(95.0),
          ),
          Text(
            text,
            style: TextStyle(fontSize: 12.0),
          )
        ],
      ),
    );
  }
}
