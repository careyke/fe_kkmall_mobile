import 'dart:io';

/**
 * dio agent
 * mixin error controller
 */
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:convert';
import 'package:fe_kkmall_mobile/models/response_data.dart';

const baseUrl =
    'https://www.easy-mock.com/mock/5d27516a7c78013d841db55c/kkmall';

class RequestAgent {
  RequestAgent._init(this.dio) {
    dio.options.baseUrl = baseUrl;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    dio.interceptors.add(InterceptorsWrapper(
        onResponse: _responseMiddleware, onError: _errorMiddleware));
    //忽略https网站的证书失效
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
    };
  }
  static RequestAgent _requestAgent = RequestAgent._init(Dio());

  final Dio dio; //保存一个Dio实例  保证是单例的

  factory RequestAgent() => _requestAgent;

  void _spreadError(String message) {
    print('error:$message');
    //TODO 暂时打印在控制台，后续需要展示在界面上
  }

  void _spreadWarning(String message) {
    print('error:$message');
    //TODO 暂时打印在控制台，后续需要展示在界面上
  }

  void _spreadTips(String message) {
    print('error:$message');
    //TODO 暂时打印在控制台，后续需要展示在界面上
  }

  //响应拦截器，预处理返回数据,用来抛出错误
  //建议是返回Response或者DioError类型数据
  dynamic _responseMiddleware(Response response) {
    if (response.statusCode != 200) {
      return DioError(
          message: 'request failed! statusCode:${response.statusCode}');
    }
    Map<String, dynamic> responseData = response.data;
    int code = responseData['code'];
    String message = responseData['message'];
    switch (code) {
      case 0:
        return response;
        break;
      case 1: //tips
        _spreadTips(message);
        return DioError(message: 'request success! show tips');
      case 2: //warning
        _spreadWarning(message);
        return DioError(message: 'request success! show warnings');
      default: //response error
        _spreadError(message ?? 'response error');
        return DioError(message: 'request success! show errors');
    }
  }

  //异常拦截器
  void _errorMiddleware(DioError e) {
    _spreadError(e.message);
  }

  // get请求
  Future<ResponseData> get(String path, {Map<String, dynamic> params}) async {
    ResponseData responseData;
    try {
      Response response =
          await dio.get(path, queryParameters: params);
      responseData = ResponseData.fromJson(json.decode(response.toString()));
    } on DioError catch (e) {
      responseData = null;
    }
    return responseData;
  }
}

RequestAgent requestAgent = RequestAgent();
