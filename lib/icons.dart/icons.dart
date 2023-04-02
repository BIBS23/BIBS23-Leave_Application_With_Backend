import 'package:flutter/material.dart';

class MyIcons extends StatelessWidget {
  final String iconImage;
  final void Function() onTap;
  const MyIcons({super.key,
  required this.iconImage,
  required this.onTap,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
            image: DecorationImage(
                image: AssetImage(iconImage), fit: BoxFit.cover)),
      ),
    );
  }
}
