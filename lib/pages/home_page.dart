import 'package:flutter/material.dart';
import '../services/methods.dart';
import 'package:fe_kkmall_mobile/widgets/carousel_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fe_kkmall_mobile/widgets/menu_widget.dart';
import 'dart:math';
import 'package:fe_kkmall_mobile/widgets/circular_progress_widget.dart';
import 'package:fe_kkmall_mobile/widgets/refresh_load/refresh_load_widget.dart';

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
              backgroundColor: Color(0xffffcad4),
              future: getHomePageCarousel(),
            ),
            MenuWidget(),
            // Container(
            //   // child: Transform.rotate(
            //   //   angle: pi / 3,
            //   //   child: Icon(Icons.arrow_back),
            //   // ),
            //   // child: CircularProgressIndicator(
            //   //   value:0.4
            //   // ),
            //   // padding: EdgeInsets.all(5.0),
            //   child: CircularProgressWidget(
            //     value: 1,
            //     radius: 18.0,
            //     startAngle: pi / 6,
            //     totalAngle: 5 / 3 * pi,
            //     strokeWidth: 5.0,
            //     colors: [Colors.black, Colors.black],
            //   ),
            // ),
            Container(
              height: 200.0,
              child: RefreshLoadWidget(),
            )
          ],
        ),
      ),
    );
  }
}
