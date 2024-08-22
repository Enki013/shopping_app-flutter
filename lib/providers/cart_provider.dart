import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

class CartProvider extends InheritedWidget {
  final List<Map<String, dynamic>> cartItems;
  final Function(Product, Color) addToCart;
  final Function(Product, Color) incrementQuantity;
  final Function(Product, Color) decrementQuantity;

  const CartProvider({
    super.key,
    required super.child,
    required this.cartItems,
    required this.addToCart,
    required this.incrementQuantity,
    required this.decrementQuantity,
  });

  static CartProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<CartProvider>();
  }

  @override
  bool updateShouldNotify(CartProvider oldWidget) {
    return true;
  }
}