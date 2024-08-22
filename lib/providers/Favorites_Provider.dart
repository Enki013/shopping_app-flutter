import 'package:flutter/material.dart';
import 'package:shop_app/models/Product.dart';

class FavoritesProvider extends InheritedWidget {
  final List<Product> favoriteItems;
  final Function(Product) addToFavorites;
  final Function(Product) removeFromFavorites;

  const FavoritesProvider({
    super.key,
    required super.child,
    required this.favoriteItems,
    required this.addToFavorites,
    required this.removeFromFavorites,
  });

  static FavoritesProvider? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<FavoritesProvider>();
  }

  @override
  bool updateShouldNotify(FavoritesProvider oldWidget) {
    return true;
  }
}
