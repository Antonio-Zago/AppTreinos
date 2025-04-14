import 'package:flutter/material.dart';
import 'package:gym_squad_front_end/utils/color_constants.dart';

class AppBarDefault extends StatefulWidget implements PreferredSizeWidget {
  const AppBarDefault({super.key, required this.title});

  final String title;

  @override
  State<AppBarDefault> createState() => _AppBarDefaultState();
  
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _AppBarDefaultState extends State<AppBarDefault> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: Color(0xff202020),
      iconTheme: IconThemeData(color: Color(ColorConstants.brancoPadrao)),
      title: Text(
        widget.title,
        style: TextStyle(
          color: Color(ColorConstants.brancoPadrao),
          fontSize: 20,
          fontWeight: FontWeight.bold
        ),
      )

    );
  }
}