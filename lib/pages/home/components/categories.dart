import 'package:ecommerce_my_store/widgets/colors.dart';
import 'package:flutter/material.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = [
    "Moda",
    "Beleza",
    "Eletronicos",
    "Celulares",
    "Lar",
    "Mais",
  ];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => buildCateogry(index),
        ),
      ),
    );
  }

  Widget buildCateogry(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedIndex == index
                    ? Palette.gradient3
                    : const Color.fromARGB(255, 145, 141, 141),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: 2,
              width: 30,
              color: selectedIndex == index
                  ? Palette.gradient4
                  : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
