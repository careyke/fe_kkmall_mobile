/**
 * 使用画笔绘制自定义圆形进度条
 * 支持渐变的颜色
 */
import 'package:flutter/material.dart';
import 'dart:math';

class CircularProgressWidget extends StatelessWidget {
  CircularProgressWidget(
      {Key key,
      this.strokeWidth = 2.0,
      @required this.radius,
      this.colors,
      this.value = 0.0,
      this.startAngle = 0.0,
      this.totalAngle = 2 * pi,
      this.child})
      : super(key: key);

  final double strokeWidth; //画笔宽度
  final double radius; //绘制半径
  final List<Color> colors; // 渐变色数组
  final double startAngle; //绘制起点的角度
  final double value; //当前进度，取值是[0.0,1.0]
  final double totalAngle; //进度条总弧度[0,2*pi]
  final Widget child;

  @override
  Widget build(BuildContext context) {
    List<Color> _colors = colors;
    if (colors == null) {
      Color _colorStart = Theme.of(context).scaffoldBackgroundColor;
      Color _colorEnd = Theme.of(context).primaryColor;
      _colors = [_colorStart, _colorEnd];
    }
    return CustomPaint(
      size: Size.fromRadius(radius),
      painter: _CircularProgressPianter(
          colors: _colors,
          value: value,
          startAngle: startAngle,
          totalAngle: totalAngle,
          strokeWidth: strokeWidth,
          radius: radius),
      child: this.child,
    );
  }
}

class _CircularProgressPianter extends CustomPainter {
  _CircularProgressPianter(
      {this.strokeWidth = 2.0,
      this.colors,
      this.radius,
      this.totalAngle,
      this.value,
      this.startAngle});

  final double strokeWidth; //画笔宽度
  final double radius; //绘制半径
  final List<Color> colors; // 渐变色数组
  final double startAngle; //绘制起点的角度
  final double value; //当前进度，取值是[0.0,1.0]
  final double totalAngle; //进度条总弧度[0,2*pi]

  @override
  void paint(Canvas canvas, Size size) {
    double endAngle = value ?? 0.0;
    endAngle =
        endAngle.clamp(0.0, 1.0) * (totalAngle - startAngle) + startAngle;

    //绘制的圆会溢出，需要调整一下矩形区域
    Offset offset = Offset(strokeWidth / 2, strokeWidth / 2);
    Rect rect =
        offset & Size(size.width - strokeWidth, size.height - strokeWidth);
    Paint paint = Paint()
      ..strokeWidth = strokeWidth
      ..isAntiAlias = true
      ..style = PaintingStyle.stroke;
    // 绘制前景
    if (endAngle > startAngle) {
      paint.shader = SweepGradient(
        startAngle: startAngle,
        endAngle: endAngle,
        colors: colors,
      ).createShader(rect);

      canvas.drawArc(rect, startAngle, endAngle, false, paint);
    }
  }

  @override
  bool shouldRepaint(_CircularProgressPianter oldCustomPainter) {
    return startAngle != oldCustomPainter.startAngle ||
        value != oldCustomPainter.value ||
        totalAngle != oldCustomPainter.totalAngle;
  }
}
