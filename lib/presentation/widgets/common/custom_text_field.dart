import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.isEnabled = false,
    this.underBorder = false,
    this.outlineBorder = false,
    this.borderColor = Colors.blue,
    this.align= TextAlign.left,
  });

  final TextEditingController? controller;
  final bool isEnabled, underBorder, outlineBorder;
  final Color borderColor;
  final TextAlign align;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textAlign: align,
      enabled: isEnabled,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        border: underBorder
            ? const UnderlineInputBorder()
            : outlineBorder
                ? const OutlineInputBorder()
                : null,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder:
            UnderlineInputBorder(borderSide: BorderSide(color: borderColor)),
      ),
    );
  }
}
