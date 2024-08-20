// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:shop_app/constants.dart';
// import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

// import 'components/categories.dart';
// import 'components/new_arrival_products.dart';
// import 'components/popular_products.dart';
// import 'components/search_form.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int _selectedIndex = 0;

//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           onPressed: () {},
//           icon: SvgPicture.asset("assets/icons/menu.svg"),
//         ),
//         title: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             SvgPicture.asset("assets/icons/Location.svg"),
//             const SizedBox(width: defaultPadding / 2),
//             Text(
//               "15/2 New Texas",
//               style: Theme.of(context).textTheme.bodyLarge,
//             ),
//           ],
//         ),
//         actions: [
//           IconButton(
//             icon: SvgPicture.asset("assets/icons/Notification.svg"),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         physics: const BouncingScrollPhysics(
//             parent: AlwaysScrollableScrollPhysics()),
//         padding: const EdgeInsets.all(defaultPadding),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Explore",
//               style: Theme.of(context)
//                   .textTheme
//                   .headlineMedium!
//                   .copyWith(fontWeight: FontWeight.w500, color: Colors.black),
//             ),
//             const Text(
//               "best Outfits for you",
//               style: TextStyle(fontSize: 18),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(vertical: defaultPadding),
//               child: SearchForm(),
//             ),
//             const Categories(),
//             const NewArrivalProducts(),
//             const PopularProducts(),
//           ],
//         ),
//       ),
//       bottomNavigationBar: SalomonBottomBar(
//         currentIndex: _selectedIndex,
//         onTap: _onItemTapped,
//         items: [
//           /// Home
//           SalomonBottomBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/home.svg",
//               color: _selectedIndex == 0 ? primaryColor : Colors.grey,
//             ),
//             title: Text("Home"),
//             selectedColor: Colors.purple,
//           ),

//           /// Cart
//           SalomonBottomBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/cart.svg",
//               color: _selectedIndex == 1 ? primaryColor : Colors.grey,
//             ),
//             title: Text("Cart"),
//             selectedColor: Colors.pink,
//           ),

//           /// Likes
//           SalomonBottomBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/heart2.svg",
//               color: _selectedIndex == 2 ? primaryColor : Colors.grey,
//             ),
//             title: Text("Likes"),
//             selectedColor: Colors.orange,
//           ),

//           /// Profile
//           SalomonBottomBarItem(
//             icon: SvgPicture.asset(
//               "assets/icons/User.svg",
//               color: _selectedIndex == 3 ? primaryColor : Colors.grey,
//             ),
//             title: Text("Profile"),
//             selectedColor: Colors.teal,
//           ),
//         ],
//       ),
//     );
//   }
// }
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
            title: Text("Home"),
            selectedColor: Colors.purple,
          ),

          /// Cart
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/cart.svg",
              color: _selectedIndex == 1 ? primaryColor : Colors.grey,
            ),
            title: Text("Cart"),
            selectedColor: Colors.pink,
          ),

          /// Likes
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/heart2.svg",
              color: _selectedIndex == 2 ? primaryColor : Colors.grey,
            ),
            title: Text("Likes"),
            selectedColor: Colors.orange,
          ),

          /// Profile
          SalomonBottomBarItem(
            icon: SvgPicture.asset(
              "assets/icons/User.svg",
              color: _selectedIndex == 3 ? primaryColor : Colors.grey,
            ),
            title: Text("Profile"),
            selectedColor: Colors.teal,
          ),
        ],
      ),
    );
  }
}