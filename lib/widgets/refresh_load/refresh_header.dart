/**
 * 下拉刷新的头部
 */
import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fe_kkmall_mobile/widgets/circular_progress_widget.dart';
import 'dart:math';
import 'package:fe_kkmall_mobile/iconfonts.dart';

class RefreshHeader extends Header {
  RefreshHeader(
      {this.key,
      this.extent = 50.0,
      this.triggerDistance = 60.0,
      completeDuration = const Duration(milliseconds: 500),
      this.pullText = '下拉即可刷新',
      this.releaseText = '释放即可刷新',
      this.refreshingText = '正在刷新...',
      this.refreshedText = '刷新完成'})
      : super(
            extent: extent,
            triggerDistance: triggerDistance,
            completeDuration: completeDuration);

  final Key key;
  final double extent; //height的高度
  final double triggerDistance; //触发刷新的高度
  final String pullText; //下来文案
  final String releaseText; //释放文案
  final String refreshingText; //正在刷新文案
  final String refreshedText; //刷新完成文案

  //构建refresh header widget的接口，由refresh_indicator中主动调用生成
  @override
  Widget contentBuilder(
      BuildContext context,
      RefreshMode refreshState,
      double pulledExtent,
      double refreshTriggerPullDistance,
      double refreshIndicatorExtent,
      AxisDirection axisDirection,
      bool float,
      Duration completeDuration,
      bool enableInfiniteRefresh,
      bool success,
      bool noMore) {
    return RefreshHeaderWidget(
        key: key,
        headerInstance: this,
        refreshState: refreshState,
        pulledExtent: pulledExtent,
        refreshTriggerPullDistance: refreshTriggerPullDistance,
        refreshIndicatorExtent: refreshIndicatorExtent,
        axisDirection: axisDirection,
        float: float,
        completeDuration: completeDuration,
        enableInfiniteRefresh: enableInfiniteRefresh,
        success: success,
        noMore: noMore);
  }
}

class RefreshHeaderWidget extends StatefulWidget {
  RefreshHeaderWidget(
      {Key key,
      this.refreshState,
      this.pulledExtent,
      this.axisDirection,
      this.refreshIndicatorExtent,
      this.refreshTriggerPullDistance,
      this.enableInfiniteRefresh,
      this.completeDuration,
      this.float,
      this.noMore,
      this.success,
      this.headerInstance})
      : super(key: key);

  final RefreshMode refreshState; //刷新头的状态
  final double pulledExtent; //已下拉的距离
  final double refreshTriggerPullDistance; //触发刷新的距离
  final double refreshIndicatorExtent; //header的高度
  final AxisDirection axisDirection;
  final bool float;
  final Duration completeDuration;
  final bool enableInfiniteRefresh;
  final bool success;
  final bool noMore;
  final RefreshHeader headerInstance;

  @override
  _RefreshHeaderWidgetState createState() => _RefreshHeaderWidgetState();
}

class _RefreshHeaderWidgetState extends State<RefreshHeaderWidget>
    with TickerProviderStateMixin<RefreshHeaderWidget> {
  String _showText;
  IconData _refreshIcon;
  //RefreshMode状态解析
  //inactive: 初始状态和最终状态
  //drag: 下拉但是还没有到触发刷新的距离
  //armed: 释放的时候直到到刷新的距离
  //refresh: 刷新的时候
  //refreshed: 刷新完成
  //done:刷新完成之后回弹的时候
  void _updateConfig() {
    switch (widget.refreshState) {
      case RefreshMode.armed:
        _showText = widget.headerInstance.refreshingText;
        _refreshIcon = null;
        _rotateController.repeat();
        break;
      case RefreshMode.refresh:
        _showText = widget.headerInstance.refreshingText;
        _refreshIcon = null;
        break;
      case RefreshMode.refreshed:
        _showText = widget.headerInstance.refreshedText;
        _refreshIcon = Iconfonts.check;
        break;
      case RefreshMode.done:
        _showText = widget.headerInstance.refreshedText;
        _refreshIcon = Iconfonts.check;
        break;
      default:
        if (widget.pulledExtent > widget.refreshTriggerPullDistance) {
          _showText = widget.headerInstance.releaseText;
          _refreshIcon = Iconfonts.arrowup;
        } else {
          _showText = widget.headerInstance.pullText;
          _refreshIcon = Iconfonts.arrowdown;
        }
    }
  }

  void _updateAnimation() {
    //refreshed的状态不一定会回调
    if (widget.refreshState == RefreshMode.refreshed ||
        widget.refreshState == RefreshMode.done ||
        widget.refreshState == RefreshMode.inactive) {
      _rotateController.stop();
    }
  }

  double get _rotateAngle {
    if (widget.refreshState == RefreshMode.refresh ||
        widget.refreshState == RefreshMode.armed) {
      return _rotateAnimation.value * 2 * pi;
    } else {
      return 0.0;
    }
  }

  double get _headerHeight {
    return widget.pulledExtent > widget.refreshIndicatorExtent
        ? widget.pulledExtent
        : widget.refreshIndicatorExtent;
  }

  double get _progressValue {
    if (widget.refreshState == RefreshMode.drag) {
      return widget.pulledExtent / widget.refreshTriggerPullDistance;
    }
    return 1.0;
  }

  Animation<double> _rotateAnimation;
  AnimationController _rotateController;

  @override
  void initState() {
    super.initState();
    _rotateController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    _rotateAnimation = Tween(begin: 0.0, end: 1.0).animate(_rotateController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Color refreshColor = Colors.white;
    _updateConfig(); //更新配置信息
    _updateAnimation();
    //外层貌似有一层scrollWidget
    return Stack(
      children: <Widget>[
        Positioned(
          left: 0.0,
          right: 0.0,
          bottom: 0.0,
          child: Container(
            height: _headerHeight,
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: widget.refreshIndicatorExtent,
              width: double.infinity,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 2.0, horizontal: 10.0),
                      child: Transform.rotate(
                          angle: _rotateAngle,
                          child: CircularProgressWidget(
                              radius: 10.0,
                              startAngle: -(3 / 8) * pi,
                              totalAngle: 7 / 4 * pi,
                              colors: [refreshColor, refreshColor],
                              value: _progressValue,
                              strokeWidth: 1.0,
                              child: Padding(
                                padding: EdgeInsets.all(3.0),
                                child: Icon(
                                  _refreshIcon,
                                  size: 18.0,
                                  color: refreshColor,
                                ),
                              )))),
                  Container(
                    width: 80.0,
                    alignment: Alignment.center,
                    child: Text(
                      _showText,
                      style: TextStyle(fontSize: 12.0, color: refreshColor),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
