import 'package:flutter/material.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final List<Color> colors;
  final double rating, price;
  final bool isFavourite, isPopular;

  Product({
    required this.id,
    required this.images,
    required this.colors,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });
  
}

// Our demo Products

List<Product> demoProducts = [
  Product(
    id: 1,
    images: [
      "assets/images/Popular Product 1.png",
      "assets/images/PlayStation5(2).png",
      "assets/images/PlayStation5(3).png",
    ],
    colors: [
      Color.fromARGB(255, 255, 41, 120),
      Color.fromARGB(255, 115, 55, 255),
      Colors.white,
      Colors.black,
    ],
    title: "PlayStation 5 - 1TB",
    price: 208500,
    description: description1,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 2,
    images: [
      "assets/images/Popular Product 2.png",
    ],
    colors: [
      Color.fromARGB(255, 255, 41, 120),
      Color.fromARGB(255, 115, 55, 255),
      Colors.black,
    ],
    title: "Xbox Series X",
    price: 198500,
    description: description2,
    rating: 4.1,
    isPopular: true,
  ),
  Product(
    id: 3,
    images: [
      "assets/images/Popular Product 3.png",
    ],
    colors: [
      Colors.black,
    ],
    title: "PlayStation 4 - 1TB",
    price: 136500,
    description: description3,
    rating: 4.1,
    isFavourite: true,
    isPopular: true,
  ),
  Product(
    id: 4,
    images: [
      "assets/images/marshall-emberton.png",
    ],
    colors: [
      Colors.black,
      Colors.white,
    ],
    title: "Marshall Emberton",
    price: 25800,
    description: description4,
    rating: 4.1,
    isFavourite: true,
  ),
];

const String description1 =
    "The PS5 is a home video game console developed by Sony Interactive Entertainment. It was launched on November 12, 2020…";

const String description2 =
    "Introducing Xbox Series X, the fastest, most powerful Xbox ever. Play thousands of titles from four generations of consoles—all games look and play best on...";
  
const String description3 =
    "The PlayStation 4 (PS4) is a home video game console developed by Sony Interactive Entertainment. Announced as the successor to the PlayStation 3...";

const String description4 =
    "Emberton is a compact portable speaker with the loud and vibrant sound only Marshall can deliver. Emberton utilises True Stereophonic, a unique form of multi-directional sound from Marshall... ";