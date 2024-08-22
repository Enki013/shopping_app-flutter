import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'home_page.dart';
import 'cart_page.dart';
import 'likes_page.dart';
import 'profile_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomePage(),
    CartPage(),
    LikesPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/home.svg",
              color: _selectedIndex == 0 ? primaryColor : Colors.grey,
            ),
            title: const Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Cart
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              color: _selectedIndex == 1 ? primaryColor : Colors.grey,
            ),
            title: const Text("Cart"),
            selectedColor: Colors.pink,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/heart2.svg",
              color: _selectedIndex == 2 ? primaryColor : Colors.grey,
            ),
            title: const Text("Likes"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User.svg",
              color: _selectedIndex == 3 ? primaryColor : Colors.grey,
            ),
            title: const Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}