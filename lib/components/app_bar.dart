import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget{
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onMenuPressed;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.onMenuPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      bottomOpacity: 0.0,
      elevation: 0.0,
      shadowColor: Colors.transparent,
      leading: IconButton(
        icon: const Icon(
          Icons.menu,
          color: Colors.black87,
        ),
        onPressed: () {
          onMenuPressed();
        },
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.favorite_border_outlined),
          color: Colors.black87,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          color: Colors.black87,
        ),
      ],
    );
  }
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
