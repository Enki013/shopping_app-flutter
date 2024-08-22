import 'package:flutter/material.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/screens/home/home_screen.dart';
import 'package:shop_app/providers/cart_provider.dart';
import 'package:shop_app/models/Product.dart';
import 'package:shop_app/providers/favorites_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final List<Map<String, dynamic>> cartItems = [];
  final List<Product> favoriteItems = [];

  void addToCart(Product product, Color color) {
    setState(() {
      bool productExists = false;
      for (var item in cartItems) {
        if (item['product'] == product && item['color'] == color) {
          item['quantity']++;
          productExists = true;
          break;
        }
      }
      if (!productExists) {
        cartItems.add({'product': product, 'color': color, 'quantity': 1});
      }
    });
  }

  void incrementQuantity(Product product, Color color) {
    setState(() {
      for (var item in cartItems) {
        if (item['product'] == product && item['color'] == color) {
          item['quantity']++;
          break;
        }
      }
    });
  }

  void decrementQuantity(Product product, Color color) {
    setState(() {
      for (var item in cartItems) {
        if (item['product'] == product && item['color'] == color) {
          if (item['quantity'] > 1) {
            item['quantity']--;
          } else {
            cartItems.remove(item);
          }
          break;
        }
      }
    });
  }

  void addToFavorites(Product product) {
    setState(() {
      if (!favoriteItems.contains(product)) {
        favoriteItems.add(product);
      }
    });
  }

  void removeFromFavorites(Product product) {
    setState(() {
      favoriteItems.remove(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FavoritesProvider(
      favoriteItems: favoriteItems,
      addToFavorites: addToFavorites,
      removeFromFavorites: removeFromFavorites,
      child: CartProvider(
        cartItems: cartItems,
        addToCart: addToCart,
        incrementQuantity: incrementQuantity,
        decrementQuantity: decrementQuantity,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'The Flutter Way',
          theme: ThemeData(
            scaffoldBackgroundColor: bgColor,
            primarySwatch: Colors.blue,
            fontFamily: "Gordita",
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            textTheme: const TextTheme(
              bodyMedium: TextStyle(color: Colors.black54),
            ),
          ),
          home: const HomeScreen(),
        ),
      ),
    );
  }
}