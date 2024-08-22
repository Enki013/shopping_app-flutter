import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shop_app/constants.dart';
import 'package:shop_app/providers/favorites_provider.dart';
import 'package:shop_app/screens/details/details_screen.dart';

class LikesPage extends StatelessWidget {
  const LikesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = FavoritesProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
            child: Text("Favorite",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.black, fontWeight: FontWeight.w700))),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.9,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: favoritesProvider?.favoriteItems.length ?? 0,
          itemBuilder: (context, index) {
            final product = favoritesProvider!.favoriteItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsScreen(product: product),
                  ),
                );
              },
              child: Container(
                width: 154,
                padding: const EdgeInsets.all(defaultPadding / 2),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(defaultBorderRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: 150, 
                          decoration: BoxDecoration(
                            color: product.bgColor,
                            borderRadius:
                                BorderRadius.circular(defaultBorderRadius),
                          ),
                          child: Image.asset(
                            product.image,
                            height: 132,
                          ),
                        ),
                        Positioned(
                          top: 8,
                          right: 8,
                          child: SvgPicture.asset(
                            "assets/icons/Heart.svg",
                            height: 24,
                            width: 24,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      product.title,
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: defaultPadding / 2),
                    Text(
                      "\$${product.price}",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}