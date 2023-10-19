// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  final String currentAddress;
  final Function(String) onAddressUpdated;

  const EditAddressScreen({super.key, 
    required this.currentAddress,
    required this.onAddressUpdated,
  });

  @override
  _EditAddressScreenState createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();
    addressController = TextEditingController(text: widget.currentAddress);
  }

  @override
  void dispose() {
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Address'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: addressController,
              decoration: InputDecoration(
                labelText: 'Delivery Address',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newAddress = addressController.text;
                widget.onAddressUpdated(newAddress);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
