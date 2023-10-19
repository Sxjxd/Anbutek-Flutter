import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:anbutek_app/constants.dart';

enum FormCategory {
  Complaint,
  Feedback,
  Inquiry,
  Other,
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  FormCategory _selectedCategory = FormCategory.Inquiry;

  void _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final Email email = Email(
        recipients: ['support@yourapp.com'], // Replace with your support email address
        subject: _getSubject(),
        body: 'Name: ${_nameController.text}\nEmail: ${_emailController.text}\n\n${_messageController.text}',
      );

      try {
        await FlutterEmailSender.send(email);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Email sent successfully')),
        );
        Navigator.pop(context); // Close the dialog
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send email')),
        );
      }
    }
  }

  String _getSubject() {
    switch (_selectedCategory) {
      case FormCategory.Complaint:
        return 'Complaint: ${_nameController.text}';
      case FormCategory.Feedback:
        return 'Feedback: ${_nameController.text}';
      case FormCategory.Inquiry:
        return 'Inquiry: ${_nameController.text}';
      case FormCategory.Other:
        return 'Other: ${_nameController.text}';
    }
  }

  void _selectContact(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: Text('Contact Customer Support'),
        children: [
          SimpleDialogOption(
            onPressed: () => _sendEmail(context),
            child: ListTile(
              leading: Icon(Icons.mail),
              title: Text('Email'),
              subtitle: Text('Send an email to customer support'),
            ),
          ),
          SimpleDialogOption(
            onPressed: () => _sendWhatsApp(context),
            child: ListTile(
              leading: Icon(Icons.message),
              title: Text('Message'),
              subtitle: Text('Message customer support via WhatsApp'),
            ),
          ),
        ],
      ),
    );
  }

  void _sendEmail(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@yourapp.com', // Replace with your support email address
      queryParameters: {'subject': _getSubject()},
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to send email')),
      );
    }
  }

  void _sendWhatsApp(BuildContext context) async {
    final phoneNumber = '1234567890'; // Replace with your WhatsApp phone number
    final message = 'Hello, I have an inquiry/request.';

    final Uri whatsappUri = Uri(
      scheme: 'https',
      host: 'wa.me',
      path: phoneNumber,
      queryParameters: {'text': message},
    );

    if (await canLaunch(whatsappUri.toString())) {
      await launch(whatsappUri.toString());
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Unable to open WhatsApp')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<FormCategory>(
                    value: _selectedCategory,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedCategory = newValue!;
                      });
                    },
                    decoration: InputDecoration(
                      labelText: 'Category',
                      border: OutlineInputBorder(),
                    ),
                    items: [
                      DropdownMenuItem(
                        value: FormCategory.Complaint,
                        child: Text('Complaint'),
                      ),
                      DropdownMenuItem(
                        value: FormCategory.Feedback,
                        child: Text('Feedback'),
                      ),
                      DropdownMenuItem(
                        value: FormCategory.Inquiry,
                        child: Text('Inquiry'),
                      ),
                      DropdownMenuItem(
                        value: FormCategory.Other,
                        child: Text('Other'),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      labelText: 'Message',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your message';
                      }
                      return null;
                    },
                    maxLines: 3,
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      onPressed: () => _submitForm(context),
                      style: ElevatedButton.styleFrom(
                        primary: kPrimaryColor,
                        padding: EdgeInsets.all(16.0),
                      ),
                      child: Text('Send Message'),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ElevatedButton(
                onPressed: () => _selectContact(context),
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                  padding: EdgeInsets.all(16.0),
                ),
                child: Text('Contact Customer Support'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
