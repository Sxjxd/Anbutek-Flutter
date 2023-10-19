import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_auth/firebase_auth.dart';

class ProfilePic extends StatefulWidget {
  final String? profilePictureURL;

  const ProfilePic({Key? key, this.profilePictureURL}) : super(key: key);

  @override
  _ProfilePicState createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  File? _imageFile;
  String? _uploadedFileURL;

  @override
  void initState() {
    super.initState();
    _uploadedFileURL = widget.profilePictureURL;
  }

  

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      final imageFile = File(pickedImage.path);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Confirm Image"),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Image.file(imageFile),
                  SizedBox(height: 8.0),
                  Text("Do you want to apply this image as your profile picture?"),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () async {
                  await _uploadImageToFirebase(imageFile);
                  Navigator.of(context).pop();
                },
                child: Text("Apply"),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _uploadImageToFirebase(File imageFile) async {
  try {
    final userId = FirebaseAuth.instance.currentUser!.uid;
    final storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_pictures')
        .child('$userId.jpg');

    final uploadTask = storageRef.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() {});

    if (snapshot.state == firebase_storage.TaskState.success) {
      final downloadURL = await storageRef.getDownloadURL();
      setState(() {
        _uploadedFileURL = downloadURL;
      });
    } else {
      // Handle upload failure
      print('Upload failed. ${snapshot.state}');
    }
  } catch (error) {
    // Handle the error here
    print('Error uploading image: $error');
  }
}

  @override
Widget build(BuildContext context) {
  if (_uploadedFileURL == null && widget.profilePictureURL != null) {
    _uploadedFileURL = widget.profilePictureURL;
  }
    return SizedBox(
      height: 115,
      width: 115,
      child: Stack(
        fit: StackFit.expand,
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            backgroundImage: _uploadedFileURL != null
              ? NetworkImage(_uploadedFileURL!) as ImageProvider<Object>?
              : _imageFile != null
                ? FileImage(_imageFile!) as ImageProvider<Object>?
                : AssetImage("assets/images/Profile_Avatar.jpg"),
          ),
          Positioned(
            right: -16,
            bottom: 0,
            child: SizedBox(
              height: 46,
              width: 46,
              child: TextButton(
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                    side: BorderSide(color: Colors.white),
                  ),
                  primary: Colors.white,
                  backgroundColor: Color(0xFFF5F6F9),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Select Image"),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              GestureDetector(
                                child: Text("Camera"),
                                onTap: () {
                                  _pickImage(ImageSource.camera);
                                  Navigator.of(context).pop();
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.all(8.0),
                              ),
                              GestureDetector(
                                child: Text("Select from gallery"),
                                onTap: () {
                                  _pickImage(ImageSource.gallery);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
                child: SvgPicture.asset("assets/icons/Camera Icon.svg"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
