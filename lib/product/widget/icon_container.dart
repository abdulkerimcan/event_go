import 'package:eventgo/core/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class IconContainer extends StatelessWidget {
  final IconData iconData;
  final Function()? onPress;
  const IconContainer({
    super.key,
    required this.iconData,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sized.mediumValue,
      height: context.sized.mediumValue * 1.5,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorConstants.primaryColor.withOpacity(0.1)),
      child: IconButton(
        icon: Icon(iconData),
        color: ColorConstants.primaryColor,
        onPressed: onPress,
      ),
    );
  }
}