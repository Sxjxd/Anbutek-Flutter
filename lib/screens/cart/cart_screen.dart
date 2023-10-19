import 'package:flutter/material.dart';
import 'package:anbutek_app/models/Cart.dart';
import 'package:anbutek_app/screens/checkout/checkout_screen.dart';

import 'components/cart_card.dart';

import 'components/body.dart';
import 'components/check_out_card.dart';

class CartScreen extends StatelessWidget {
  static String routeName = "/cart";

  @override
  Widget build(BuildContext context) {
    int totalItems = 0;
    int totalPrice = 0;
    for (Cart cart in demoCarts) {
      totalItems += cart.numOfItem;
      totalPrice += (cart.numOfItem * cart.product.price).toInt();
    }

    return Scaffold(
      appBar: buildAppBar(context, totalItems),
      body: Body(),
      bottomNavigationBar: CheckoutCard(
        cartItems: demoCarts,
        totalPrice: totalPrice,
      ),
    );
  }

  AppBar buildAppBar(BuildContext context, int totalItems) {
    return AppBar(
      title: Column(
        children: [
          Text(
            "Your Cart",
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          Text(
            "$totalItems items",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
