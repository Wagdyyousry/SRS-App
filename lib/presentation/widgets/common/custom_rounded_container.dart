import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class CustomRoundedContainer extends StatelessWidget {
  const CustomRoundedContainer({
    super.key,
    this.child,
    this.width,
    this.height,
    this.borderWidth = 1.5,
    this.margin,
    this.padding,
    this.onTap,
    this.enableBorder = false,
    this.radius = MySizes.cardRadiusLg,
    this.backgroundColor = Colors.white,
    this.borderColor = MyColors.grey,
  });

  final double? width, height, radius, borderWidth;
  final Widget? child;
  final bool enableBorder;
  final Color borderColor;
  final Color backgroundColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius!),
          border: enableBorder
              ? Border.all(color: borderColor, width: borderWidth!)
              : null,
        ),
        child: Center(child: child),
      ),
    );
  }
}
