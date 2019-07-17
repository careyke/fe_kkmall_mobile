import 'package:flutter/material.dart';
import '../services/methods.dart';
import 'package:fe_kkmall_mobile/widgets/carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: ScreenUtil.statusBarHeight),
      child: Center(
        child: Column(
          children: <Widget>[
            CarouselWidget(
              future: getHomePageCarousel(),
            ),
          ],
        ),
      ),
    );
  }
}
