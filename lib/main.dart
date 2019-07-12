import 'package:flutter/material.dart';
import './pages/index.dart';

void main() => runApp(KKMallApp());

class KKMallApp extends StatelessWidget{
  KKMallApp({Key key}):super(key:key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'kkmall_app',
      debugShowCheckedModeBanner: false, //去除右上角的debug标签
      home: IndexPage(),
    );
  }
}