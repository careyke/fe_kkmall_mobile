import 'dart:async';

import './request_agent.dart';
import '../models/carousel.dart';
import 'package:fe_kkmall_mobile/models/response_data.dart';

// 获取首页的轮播图
Future<List<Carousel>> getHomePageCarousel() async {
  ResponseData responseData = await requestAgent.get('/homepage/carousel');
  List list = List();
  if (responseData != null && responseData.data is List) {
    list = responseData.data;
  }
  List<Carousel> carousels =
      list.map((item) => Carousel.fromJson(item)).toList();
  return carousels;
}
