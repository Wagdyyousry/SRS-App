import 'package:flutter/material.dart';

class CustomDropDownMenu extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    required this.hint,
    required this.onChanged,
    this.iconSize,
    this.smallText = false,
  });
  final void Function(String? value) onChanged;
  final String hint;
  final List<String> items;
  final double? iconSize;
  final bool smallText;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      isExpanded: true,
      hint: Text(hint),
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.sort, size: iconSize),
      ),
      items: [
        for (var item in items)
          DropdownMenuItem(
            value: item,
            child: Text(
              item,
              style: TextStyle(color: Colors.black, fontSize: 12),
            ),
          ),
      ],
    );
  }
}
