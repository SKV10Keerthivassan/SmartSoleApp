import 'package:flutter/material.dart';

/*
class ImageWithCircle extends StatelessWidget {
  final String imagePath;
  final Offset circlePosition;
  final double circleRadius;
  final double value;
  final String text;

  ImageWithCircle({
    required this.imagePath,
    required this.circlePosition,
    required this.circleRadius,
    required this.value,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:Container(
        width: double.infinity,
        height: 2000,
        child: Stack(
          children: [
            Image.asset(
              imagePath, 
              width: 450,
              height: 550,
              fit: BoxFit.contain,
            ),
            Positioned(
              top: circlePosition.dy - circleRadius,
              left: circlePosition.dx - circleRadius,
              child: Container(
                width: circleRadius * 2,
                height: circleRadius * 2,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: getColorForValue(value),
                ),
                child: Center(
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Color getColorForValue(double value) {
    if (value < 50) {
      return Colors.green;
    } else if (value < 75) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}*/


class CircleInfo {
  final double left;
  final double top;
  final String text;
  double value;

  CircleInfo({required this.left, required this.top, required this.text, required this.value});
}

class CircleContainer extends StatelessWidget {
  final String text;
  double value;
  
  CircleContainer(this.text,this.value);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 65,
      height: 65,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: getColorForValue(value),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

 getColorForValue(double value)  {

    
    if (value < 700) {
      return Colors.green;
    } else if (value < 1600) {
      return Colors.yellow;
    } else {
      return Colors.red;
    }
  }
}

