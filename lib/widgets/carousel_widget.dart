import 'package:flutter/material.dart';
import 'package:fe_kkmall_mobile/models/carousel.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _BaseCarouselSidget extends StatelessWidget {
  _BaseCarouselSidget({Key key, @required this.carouselList,this.backgroundColor}) : super(key: key);
  final List<Carousel> carouselList;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.symmetric(vertical: 5.0),
      height: ScreenUtil.getInstance().setHeight(350),
      child: Swiper(
          itemCount: carouselList.length,
          autoplay: true,
          viewportFraction:0.85,
          scale:0.9,
          autoplayDelay:5000,
          pagination: SwiperPagination(
            margin: EdgeInsets.all(5.0),
            builder: DotSwiperPaginationBuilder(
              color: Colors.grey
            )
          ),
          itemBuilder: (BuildContext context, int index) {
            return Image.network(
              carouselList[index].url,
              key: Key(carouselList[index].id),
              fit: BoxFit.fill,
            );
          }),
    );
  }
}

const defaultCarouselData = {
  'id': '000',
  'url':'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=238688165,407090516&fm=26&gp=0.jpg',
  'title':'default picture'
};

class CarouselWidget extends StatelessWidget {
  CarouselWidget({Key key, this.future, this.initData, this.backgroundColor}) : super(key: key);
  final Future future;
  final List initData;
  final Color backgroundColor;

  List<Carousel> getDefaultData(){
    List<Carousel> carousel = List<Carousel>();
    carousel.add(Carousel.fromJson(defaultCarouselData));
    return carousel;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        initialData: initData ?? getDefaultData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return _BaseCarouselSidget(
            carouselList: snapshot.data,
            backgroundColor: backgroundColor
          );
        });
  }
}
