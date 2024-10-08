import 'package:flutter/material.dart';

class Product {
  final String image, title, description;
  final int price;
  final Color bgColor;
  final String category;
  final String gender; 
  final List<Color> colors;
  final List<bool> isActive; 
  Product({
    required this.image,
    required this.title,
    required this.price,
    required this.description,
    this.bgColor = const Color(0xFFEFEFF2),
    required this.category,
    required this.gender, 
    required this.colors,
    required this.isActive, 
  });
}

List<Product> demo_product = [
  Product(
    image: "assets/images/product_0.png",
    title: "Long Sleeve Shirts",
    price: 165,
    description: "Comfortable long sleeve shirts",
    bgColor: const Color(0xFFFEFBF9),
    category: "Shirt",
    gender: "Man",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A), const Color(0xFFF4E5C3)],
    isActive: [true, false, false],
  ),
  Product(
    image: "assets/images/product_1.png",
    title: "Casual Henley Shirts",
    price: 99,
    description: "Casual and stylish Henley shirts",
    category: "Shirt",
    gender: "Man",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A)],
    isActive: [true, false],
  ),
  Product(
    image: "assets/images/product_2.png",
    title: "Curved Hem Shirts",
    price: 180,
    description: "Trendy curved hem shirts",
    bgColor: const Color(0xFFF8FEFB),
    category: "Shirt",
    gender: "Man",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A), const Color(0xFFF4E5C3)],
    isActive: [true, false, false],
  ),
  Product(
    image: "assets/images/product_3.png",
    title: "Casual Nolin",
    price: 149,
    description: "Casual Nolin shirts for everyday wear",
    bgColor: const Color(0xFFEEEEED),
    category: "Shirt",
    gender: "Man",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A)],
    isActive: [true, false],
  ),
  Product(
    image: "assets/images/product_4.png",
    title: "Summer Dress",
    price: 120,
    description: "Light and breezy summer dress",
    bgColor: const Color(0xFFF8E1E1),
    category: "Dress",
    gender: "Woman",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A), const Color(0xFFF4E5C3)],
    isActive: [true, false, false],
  ),
  Product(
    image: "assets/images/product_5.png",
    title: "Formal Pants",
    price: 200,
    description: "Elegant formal pants",
    bgColor: const Color(0xFFE1F8E1),
    category: "Pants",
    gender: "Man",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A)],
    isActive: [true, false],
  ),
  Product(
    image: "assets/images/product_6.png",
    title: "Casual Tshirt",
    price: 80,
    description: "Comfortable casual t-shirt",
    bgColor: const Color(0xFFE1E1F8),
    category: "Tshirt",
    gender: "Man",
    colors: [const Color(0xFFBEE8EA), const Color(0xFF141B4A), const Color(0xFFF4E5C3)],
    isActive: [true, false, false],
  ),
];