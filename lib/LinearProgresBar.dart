import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LinearProgressBarCustom extends StatelessWidget {
  final double progress;
  final double
      circlePosition; // Position where the circle indicator should appear
  final double circleSize; // Size of the circle indicator
  final Color color;
  final Color backgroundColor;

  LinearProgressBarCustom({
    required this.progress,
    required this.circlePosition,
    this.circleSize = 20.0,
    this.color = Colors.blue,
    this.backgroundColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    double progressBarWidth = MediaQuery.of(context).size.width - circleSize;
    double progressWidth = progressBarWidth * progress;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          height: circleSize,
          width: progressBarWidth,
          color: backgroundColor,
        ),
        Container(
          height: circleSize,
          width: progressWidth,
          color: color,
        ),
        Positioned(
          left: progressWidth - circleSize / 2,
          top: -circleSize / 20,
          child: Container(
            height: circleSize,
            width: circleSize,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: color, width: 2.0),
            ),
          ),
        ),
      ],
    );
  }
}
