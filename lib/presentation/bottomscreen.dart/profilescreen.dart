import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../dbmodels/profile.dart'; // Ensure this points to your Profile model

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final ImagePicker _picker = ImagePicker();
  File? pickedImage;
  late Box<Profile> profileBox;

  @override
  void initState() {
    super.initState();
    // Open the box of type Box<Profile>
    profileBox = Hive.box<Profile>('profileBox');
    _loadProfileData(); // Load profile data from Hive
  }

  // Load profile data (including the image) from Hive
  void _loadProfileData() {
    Profile? profile = profileBox.get('userProfile');
    if (profile != null && profile.imagePath != null) {
      setState(() {
        pickedImage = File(profile.imagePath!); // Load image from stored path
      });
    }
  }

  // Function to pick an image and store it in Hive
  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        pickedImage = File(image.path); // Update the picked image
      });

      // Fetch existing profile or create a new one
      Profile existingProfile = profileBox.get('userProfile') ??
          Profile(
            name: 'Murshid Iqbaal K M',
            bio: 'Powered by ABM',
            imagePath: image.path,
          );

      // Update imagePath
      existingProfile.imagePath = image.path;

      // Debug print to check if the path is correct
      print("Image path to be saved: ${existingProfile.imagePath}");

      // Save updated profile to Hive
      await profileBox.put('userProfile', existingProfile);

      // Verify that the profile has been saved
      Profile? savedProfile = profileBox.get('userProfile');
      print(
          "Saved Profile: Name: ${savedProfile?.name}, Bio: ${savedProfile?.bio}, Image Path: ${savedProfile?.imagePath}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Stack(
                children: [
                  // Circle Avatar with shadow effect
                  Material(
                    elevation: 100,
                    shape: const CircleBorder(),
                    shadowColor: Colors.black.withOpacity(0.9),
                    child: CircleAvatar(
                      radius: 120,
                      backgroundImage: pickedImage != null
                          ? FileImage(pickedImage!) // Display the picked image
                          : null, // Display nothing if no image is picked
                      child: pickedImage == null
                          ? const Icon(Icons.person,
                              size: 100) // Placeholder if no image
                          : null,
                    ),
                  ),
                  Positioned(
                    right: 30,
                    bottom: 8,
                    child: GestureDetector(
                      onTap:
                          pickImage, // Call pickImage when the icon is tapped
                      child: const Icon(Icons.add_a_photo, size: 30),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20),
                ),
                width: 200,
                height: 40,
                child: const Center(child: Text('Murshid Iqbaal K M')),
              ),
            ),
            Text(
              'Powered by ABM',
              style: TextStyle(color: Colors.grey.shade500, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
