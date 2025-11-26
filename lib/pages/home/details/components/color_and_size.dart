import 'package:ecommerce_my_store/pages/home/details/components/color_dot.dart';
import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';

class ColorAndSize extends StatelessWidget {
  const ColorAndSize({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("Color"),
              Row(
                children: <Widget>[
                  DotColor(
                    color: Color(0xFF356C95),
                    isSelected: true,
                  ),
                  DotColor(color: Color(0xFFF8C078)),
                  DotColor(color: Color(0xFFA29B9B)),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: TextStyle(color: Palette.gradient3),
              children: [
                TextSpan(text: "Size\n"),
                TextSpan(
                  text: "12 cm",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(fontWeight: FontWeight.bold),
                )
              ]
            ),
          ),
        ),
      ],
    );
  }
}