import 'package:flutter/material.dart';
import 'package:anbutek_app/models/Product.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<bool> wishlistStatus = List.generate(demoProducts.length, (index) => true);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Wishlist",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: demoProducts.length,
              itemBuilder: (context, index) {
                final product = demoProducts[index];
                return buildWishlistItem(context, product, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWishlistItem(BuildContext context, Product product, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 2,
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: ListTile(
          leading: Image.asset(
            product.images[0],
            width: 60,
            height: 60,
          ),
          title: Text(
            product.title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Text(
            "Price: \LKR ${product.price.toStringAsFixed(2)}",
          ),
          trailing: IconButton(
            icon: Icon(
              wishlistStatus[index] ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: () {
              setState(() {
                wishlistStatus[index] = !wishlistStatus[index];
              });
            },
          ),
        ),
      ),
    );
  }
}

