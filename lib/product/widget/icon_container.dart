import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class IconContainer extends StatelessWidget {
  final IconData iconData;
  final Function()? onPress;
  final Color color;
  const IconContainer({
    super.key,
    required this.iconData,
    required this.onPress, required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sized.mediumValue,
      height: context.sized.mediumValue * 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color.withOpacity(0.1)),
      child: IconButton(
        icon: Icon(iconData),
        color: color,
        onPressed: onPress,
      ),
    );
  }
}
