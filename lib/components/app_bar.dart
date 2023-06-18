import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback onMenuPressed;
  final String title;

  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.onMenuPressed,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
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
          print('APP BAR!!!!!');
          print(scaffoldKey);
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
