import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const categoryData = [
  {
    'text': '牛肉面',
    'url': 'images/noodles.png',
  },
  {
    'text': '鸡肉',
    'url': 'images/chicken.png',
  },
  {
    'text': '香蕉',
    'url': 'images/banana.png',
  },
  {
    'text': '酒水',
    'url': 'images/wine.png',
  },
  {
    'text': '蛋糕',
    'url': 'images/birthday-cake.png',
  },
  {
    'text': '苹果',
    'url': 'images/apple.png',
  },
  {
    'text': '玉米',
    'url': 'images/maize.png',
  },
  {
    'text': '牛奶',
    'url': 'images/milk.png',
  },
  {
    'text': '梨子',
    'url': 'images/pear.png',
  },
  {
    'text': '餐具',
    'url': 'images/waiter.png',
  }
];

class CategoryWidget extends StatelessWidget {
  CategoryWidget({Key key}) : super(key: key);

  List<_CategoryItem> _getCateItems() {
    return categoryData.map((item) {
      return _CategoryItem(
        url: item['url'],
        text: item['text'],
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(300.0),
      color: Color(0xffffffff),
      alignment: Alignment.center,
      child: GridView.count(
        crossAxisCount: 5,
        padding: EdgeInsets.all(0.0),
        childAspectRatio:ScreenUtil.getInstance().scaleWidth / ScreenUtil.getInstance().scaleHeight,
        // physics: NeverScrollableScrollPhysics(),
        children: _getCateItems(),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  _CategoryItem({Key key, this.url, this.text}) : super(key: key);
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
          Image.asset(url,
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
