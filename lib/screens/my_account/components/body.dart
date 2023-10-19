import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:anbutek_app/constants.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.all(20),
        child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDataFromFirestore(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userData = snapshot.data!.data();
              final email = userData!['email'];
              final firstName = userData['firstName'];
              final lastName = userData['lastName'];
              final phoneNumber = userData['phoneNumber'];
              final address = userData['address'];

              _addressController.text = address;

              return Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(25),
                 
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    SizedBox(height: 40),
                    Row(
                      children: [
                        Flexible(
                          flex: 1,
                          child: buildInfoColumn('First Name', firstName),
                        ),
                        SizedBox(width: 20),
                        Flexible(
                          flex: 1,
                          child: buildInfoColumn('Last Name', lastName),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    buildInfoRow('Email', email),
                    SizedBox(height: 20),
                    buildInfoRow('Phone Number', phoneNumber),
                    SizedBox(height: 20),
                    buildAddressFormField(address),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => updateAddress(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: kPrimaryColor,
                      ),
                      child: Text('Update Profile'),
                    ),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error retrieving user data'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDataFromFirestore() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    final snapshot = await userRef.get();
    return snapshot;
  }

  Widget buildInfoColumn(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Widget buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 5),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

Widget buildAddressFormField(String address) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Address',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 5),
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: TextFormField(
          controller: _addressController,
          style: TextStyle(fontSize: 16),
          decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            border: InputBorder.none,
            hintText: 'Enter your address',
            hintStyle: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      ),
    ],
  );
}





  void updateAddress() async {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final userRef = FirebaseFirestore.instance.collection('users').doc(userId);
    await userRef.update({'address': _addressController.text});
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Address updated')),
    );
  }
}
