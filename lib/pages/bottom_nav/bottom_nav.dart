import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/pages/cart/cart_page.dart';
import 'package:food_delivery/pages/favorite/favorite_page.dart';
import 'package:food_delivery/pages/UserPages/profile_page.dart';
import 'package:food_delivery/pages/home/home_page.dart';
import 'package:food_delivery/provider/no_internet.dart';
import 'package:food_delivery/provider/provider_internet.dart';
import 'package:provider/provider.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({
    super.key,
  });

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int index = 0;
  List<Widget> pages = [
    const HomePage(),
    const CartPage(),
    const FavoritePage(),
    const ProfilePage()
  ];

  @override
  void initState() {
    Provider.of<ProviderInternet>(context, listen: false).startMonitoring();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body:
          //Expanded(child: pages.elementAt(index)),

          Consumer<ProviderInternet>(builder: (context, value, child) {
        return value.isOnline? Container(
          color: Colors.transparent,
          child: IndexedStack(
            index: index,
            children: pages,
          ),
        ):const NoInternet();
      }),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: Colors.transparent,
        color: Colors.red,
        index: index,
        items: const <Widget>[
          Icon(Icons.home, size: 30),
          Icon(Icons.shopping_bag, size: 30),
          Icon(Icons.favorite, size: 30),
          Icon(Icons.account_box, size: 30),
        ],
        onTap: (index) {
          //Handle button tap
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}
