import 'package:flutter/material.dart';


class Body extends StatelessWidget {
  
  const Body({super.key});


  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'My Orders',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Replace with the actual number of orders
              itemBuilder: (context, index) {
                final orderStatus = index % 3; // Example order status (0: Delivered, 1: Cancelled, 2: Returned)

                return ListTile(
                  leading: Icon(Icons.shopping_bag),
                  title: Text('Order ${index + 1}'),
                  subtitle: Text('Order details'),
                  trailing: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '\$99.99', // Replace with the actual order amount
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        getOrderStatusText(orderStatus),
                        style: TextStyle(
                          color: getOrderStatusColor(orderStatus),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to order details screen
                  },
                  onLongPress: () {
                    if (orderStatus == 1) {
                      // Navigate to cancelled orders screen
                    } else if (orderStatus == 2) {
                      // Navigate to returned orders screen
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  String getOrderStatusText(int orderStatus) {
    switch (orderStatus) {
      case 0:
        return 'Delivered';
      case 1:
        return 'Cancelled';
      case 2:
        return 'Returned';
      default:
        return '';
    }
  }

  Color getOrderStatusColor(int orderStatus) {
    switch (orderStatus) {
      case 0:
        return Color.fromARGB(255, 0, 74, 173);
      case 1:
        return Color.fromARGB(255, 246, 104, 94);
      case 2:
        return Color.fromARGB(255, 255, 171, 44);
      default:
        return Colors.black;
    }
  }
}
