import 'package:flutter/material.dart';
import 'package:flutter_application_1/Services/profile_service.dart';

class AddProfile extends StatefulWidget {
  const AddProfile({super.key});

  @override
  State<AddProfile> createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  ProfileService profileService = ProfileService();

  Future<void> add() async {
    try {
      await profileService.addProfile(
        name: nameController.text.trim(),
        age: ageController.text.trim(),
        address: addressController.text.trim(),
        email: emailController.text.trim(),
      );
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Addedd successfully')));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    addressController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Profile details'), centerTitle: true),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Enter Your name:'),
          ),

          SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                label: Text('Name'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Enter Your Age:'),
          ),

          SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: ageController,
              decoration: InputDecoration(
                label: Text('Age'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Enter Your Address:'),
          ),

          SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: addressController,
              decoration: InputDecoration(
                label: Text('Address'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Text('Enter Your email'),
          ),

          SizedBox(height: 5),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: add,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('Submit'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
