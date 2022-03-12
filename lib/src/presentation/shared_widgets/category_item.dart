import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String itemName;
  final Function() onPress;
  const CategoryItem({Key? key, required this.itemName, required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      color: Colors.white,
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Center(child: Text(itemName)),
        ),
      ),
    );
  }
}
