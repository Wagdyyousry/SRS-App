import 'package:flutter/material.dart';
import 'package:srs_system/utils/constants/colors.dart';

class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppBarWidget({super.key, required this.title, this.actions});
  final List<Widget>? actions;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(10),
        bottomRight: Radius.circular(10),
      ),
      child: AppBar(
        actions: actions,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: MyColors.appBarColor,
        elevation: 10,
        shadowColor: Colors.grey,
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 23,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(47);
}
