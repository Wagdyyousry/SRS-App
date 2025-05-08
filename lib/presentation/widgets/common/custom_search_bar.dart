import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    super.key,
    required this.onChanged,
    this.height = 50,
    this.hint = "Search for name/specialization",
  });
  final void Function(String)? onChanged;
  final double height;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: SearchBar(
        onChanged: onChanged,
        hintText: hint,
        leading: const Icon(Icons.search),
        shape: const WidgetStatePropertyAll(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }
}
