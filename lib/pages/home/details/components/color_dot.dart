import 'package:flutter/material.dart';

class DotColor extends StatelessWidget {
  final Color color;
  final bool isSelected;
  const DotColor({super.key, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(top: 20 / 4, right: 20 / 2),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: isSelected ? color : Colors.transparent),
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      ),
    );
  }
}