import 'package:flutter/material.dart';

class CartCounter extends StatefulWidget {
  final ValueChanged<int>? onQuantityChanged;

  const CartCounter({
    super.key,
    this.onQuantityChanged,
  });

  @override
  State<CartCounter> createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numofItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildOutlinedButton(
          icon: Icons.remove,
          press: () {
            if (numofItems > 1) {
              setState(() {
                numofItems--;
                widget.onQuantityChanged?.call(numofItems);
              });
            }
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20 / 2),
          child: Text(
          numofItems.toString().padLeft(2, "0"), 
          style: Theme.of(context).textTheme.headlineSmall),
        ),
        buildOutlinedButton(
          icon: Icons.add,
          press: () {
            setState(() {
              numofItems++;
              widget.onQuantityChanged?.call(numofItems);
            });
          },
        ),
      ],
    );
  }

  SizedBox buildOutlinedButton({IconData? icon, VoidCallback? press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        onPressed: press,
        child: Icon(icon),
      ),
    );
  }
}

