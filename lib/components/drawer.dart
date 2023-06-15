import 'package:flutter/material.dart';


class CustomDrawer extends StatefulWidget {
  final double tileFontSize;
  final double divHeight;
  final double tileDensity;

  const CustomDrawer({
    super.key,
    required this.tileFontSize,
    required this.divHeight,
    required this.tileDensity,
  });

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool light = true;
  
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fitWidth,
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1591202585597-839c6965c443?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MzI4fHxneW18ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=500&q=60'))),
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Any%',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -4.0,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Smash your PB's",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.0,
                        ),
                      ),
                    ),
                    Container(
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextButton.icon(
                          onPressed: () {},
                          icon: const Text(
                            'Sign in',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0.0,
                            ),
                          ),
                          label: const Icon(
                            Icons.arrow_forward_ios_sharp,
                            size: 10,
                            color: Colors.white,
                          )),
                    ),
                  ],
                )),
              )
            ],
          ),
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          leading: const Icon(
            Icons.home_filled,
            color: Colors.black,
          ),
          title: Text(
            'LOG',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.tileFontSize),
          ),
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 235,
              height: widget.divHeight,
              child: Material(color: Colors.grey.shade200),
            ),
          ],
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          leading: const Icon(
            Icons.shopping_bag_outlined,
            color: Colors.black,
          ),
          title: Text(
            "PB's",
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.tileFontSize),
          ),
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 235,
              height: widget.divHeight,
              child: Material(color: Colors.grey.shade200),
            ),
          ],
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          leading: const Icon(
            Icons.favorite_border_outlined,
            color: Colors.black,
          ),
          title: Text(
            'DATA',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.tileFontSize),
          ),
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 235,
              height: widget.divHeight,
              child: Material(color: Colors.grey.shade200),
            ),
          ],
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          leading: const Icon(
            Icons.person,
            color: Colors.black,
          ),
          title: Text(
            'MY ACCOUNT',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.tileFontSize),
          ),
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 235,
              height: widget.divHeight,
              child: Material(color: Colors.grey.shade200),
            ),
          ],
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          leading: const Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text(
            'APP SETTINGS',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.tileFontSize),
          ),
          onTap: () {},
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              width: 235,
              height: widget.divHeight,
              child: Material(color: Colors.grey.shade200),
            ),
          ],
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          leading: const Icon(
            Icons.info_outline,
            color: Colors.black,
          ),
          title: Text(
            'HELP & FAQS',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: widget.tileFontSize),
          ),
          onTap: () {},
        ),
        SizedBox(
          height: 7,
          child: Material(color: Colors.grey.shade200),
        ),
        
        SizedBox(
          height: 7,
          child: Material(color: Colors.grey.shade200),
        ),
        Padding(
          padding: const EdgeInsets.all(4.0),
          child: ListTile(
            visualDensity:
                VisualDensity(horizontal: 0, vertical: widget.tileDensity),
            title: Text(
              'MORE SWEG',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: widget.tileFontSize,
                  color: Colors.grey),
            ),
            onTap: () {},
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 250,
              height: widget.divHeight,
              child: Material(color: Colors.grey.shade200),
            ),
          ],
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          title: Text(
            'Unlimited Next Day Delivery',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: widget.tileFontSize,
                color: Colors.black87),
          ),
          onTap: () {},
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          title: Text(
            'Our environmental & ethics policy',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: widget.tileFontSize,
                color: Colors.black87),
          ),
          onTap: () {},
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          title: Text(
            'Gift Vouchers',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: widget.tileFontSize,
                color: Colors.black87),
          ),
          onTap: () {},
        ),
        ListTile(
          visualDensity:
              VisualDensity(horizontal: 0, vertical: widget.tileDensity),
          title: Text(
            'About us',
            style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: widget.tileFontSize,
                color: Colors.black87),
          ),
          onTap: () {},
        ),
      ],
    ));
  }
}
