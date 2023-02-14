import 'dart:math';

import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class TextDemo extends StatefulWidget {
  @override
  _TextDemoState createState() => _TextDemoState();
}

class _TextDemoState extends State<TextDemo> {
  static const Color color0 = Color(0xff00aa00);
  static const Color color1 = Color(0xffeeaa00);
  static const Color color2 = Color(0xffaa0000);
  static const double radius0 = 0.0;

  Matrix4 matrix = Matrix4.identity();
  double radius = radius0;
  Color? color = color0;
  double fontSize = 15;
  double scaleFactor = 1.0;
  ValueNotifier<int> notifier = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: Stack(
        children: [
          MatrixGestureDetector(
            onScaleStart: (d) {
              setState(() {
                scaleFactor = d.scale.toDouble();
              });
            },
            onScaleEnd: (d) {},
            onMatrixUpdate: (m, tm, sm, rm) {
              matrix = MatrixGestureDetector.compose(matrix, tm, sm, null);

              var angle = MatrixGestureDetector.decomposeToValues(m).rotation;
              double t = (1 - cos(2 * angle)) / 2;

              // radius = radiusTween.transform(t) as double;
              // color = colorTween.transform(t);
              notifier.value++;
            },
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.topLeft,
              // color: Color(0xff444444),
              // height: 100, width: 300, color: Colors.red,
              child: AnimatedBuilder(
                animation: notifier,
                builder: (ctx, child) {
                  return Transform(
                    transform: matrix,
                    child: Container(
                      alignment: Alignment.center,
                      color: Colors.amber,
                      constraints: BoxConstraints(
                        maxHeight: 180,
                      ),
                      child: Text(
                          ' you can move & scale me (and "rotate" too) helloooo you listent you can move & scale me (and "rotate" too) helloooo you listent',
                          textAlign: TextAlign.center,
                          maxLines: 4,
                          textScaleFactor: scaleFactor,
                          softWrap: true,
                          style: Theme.of(ctx)
                              .textTheme
                              .headlineMedium!
                              .copyWith(color: Colors.white)),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
