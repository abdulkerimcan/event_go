import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({
    super.key,
    required this.context, required this.imagePath, required this.title,
  });
  final String imagePath;
  final String title;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(offset: Offset(-0.3, 0.2)),
        BoxShadow(offset: Offset(0.1, 0.4))
      ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
      width: context.sized.width * 0.4,
      height: context.sized.height * 0.07,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(
            imagePath,
            height: context.sized.mediumValue,
            width: context.sized.mediumValue,
          ),
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(color: Colors.black),
          )
        ],
      ),
    );
  }
}