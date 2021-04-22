import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color: Colors.white,
      this.selectedColor: Colors.white,
      this.dotSize = 7.5,
      this.selectDotSize = 14.0})
      : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors.white`.
  final Color color;

  final Color selectedColor;

  // The base size of the dots
  final double dotSize;

  final double selectDotSize;

  // The increase in the size of the selected dot
  final double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  final double _kDotSpacing = 18.0;

  Widget _buildDot(int index) {
    double selectedness = Curves.easeOut.transform(
      max(
        0.0,
        1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
      ),
    );
    double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;

    var currentColor = (zoom >= 1 && zoom <= 1.5) ? color : selectedColor;

    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: currentColor,
          type: MaterialType.circle,
          child: new Container(
            width: getSizeByZoom(zoom),
            height: getSizeByZoom(zoom),
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  double getSizeByZoom(double zoom) {
    return (zoom == 2)
        ? selectDotSize
        : (dotSize * zoom > selectDotSize)
            ? selectDotSize
            : dotSize * zoom;
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
