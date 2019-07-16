import 'package:flutter/material.dart';
import '../services/methods.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getHomePageCarousel().then((data){
      print(data);
    });
    return Center(
      child: Text('homepage page'),
    );
  }
}
