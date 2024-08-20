import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

class CartProvider extends InheritedWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Product, Color) addToCart;
  final Function(Product, Color) incrementQuantity;
  final Function(Product, Color) decrementQuantity;

  CartProvider({
    Key? key,
    required Widget child,
    required this.cartItems,
    required this.addToCart,
    required this.incrementQuantity,
    required this.decrementQuantity,
  }) : super(key: key, child: child);

  static CartProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  @override
  bool updateShouldNotify(CartProvider oldWidget) {
    return true;
  }
}