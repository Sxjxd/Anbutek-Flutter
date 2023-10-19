import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:anbutek_app/constants.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10, left: 10),
          child: Text(
            'Your Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        buildNotificationItem(
          svgIcon: 'assets/icons/order_success.svg',
          title: 'Order Arrived',
          description: 'Order 7701 has been completed & reached your destination. Please rate your order.',
        ),
        buildNotificationItem(
          svgIcon: 'assets/icons/order_success.svg',
          title: 'Order Success',
          description: 'Order Description',
        ),
        buildNotificationItem(
          svgIcon: 'assets/icons/payment_confirmed.svg',
          title: 'Payment Confirmed',
          description: 'Order Description',
        ),
        buildNotificationItem(
          svgIcon: 'assets/icons/order_cancel.svg',
          title: 'Order Cancelled',
          description: 'Order Description',
        ),
      ],
    );
  }

  Widget buildNotificationItem({
    required String svgIcon,
    required String title,
    required String description,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 25),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.grey.withOpacity(0.2),
            ),
            child: SvgPicture.asset(
              svgIcon,
              color: kPrimaryColor.withOpacity(0.9),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 14,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
