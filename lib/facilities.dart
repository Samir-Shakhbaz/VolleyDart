import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FacilitiesPage extends StatefulWidget {
  @override
  _FacilitiesPageState createState() => _FacilitiesPageState();
}

class _FacilitiesPageState extends State<FacilitiesPage> {
  final List<Map<String, String?>> facilities = [
    {"name": "Sand Court A", "location": "Los Angeles", "surface": "Sand", "courts": "2", "image": null},
    {"name": "Grass Field B", "location": "Chicago", "surface": "Grass", "courts": "1", "image": null},
    {"name": "Indoor Arena C", "location": "New York", "surface": "Indoor", "courts": "3", "image": null},
    {"name": "Dale F. Halton Arena", "location": "Charlotte, NC", "surface": "Indoor", "courts": "5", "image": null},
    {"name": "Carolina Volleyball Center", "location": "Columbia, SC", "surface": "Indoor", "courts": "4", "image": null},
    {"name": "Northlake Sports Center", "location": "Charlotte, NC", "surface": "Indoor", "courts": "6", "image": null},
    {"name": "The Sandbox", "location": "Charlotte, NC", "surface": "Sand", "courts": "3", "image": null},
    {"name": "Thirsty Social Club", "location": "Belmont, NC", "surface": "Sand", "courts": "2", "image": null},
    {"name": "Carolina CHAOS Volleyball Club", "location": "1281 Biscayne Dr., Concord, NC", "surface": "Indoor", "courts": "2", "image": null},
    {"name": "Abbey's Academy Inc.", "location": "Charlotte, NC", "surface": "Indoor", "courts": "1", "image": null},
    {"name": "Sports Connection", "location": "Charlotte, NC", "surface": "Indoor", "courts": "4", "image": null},
    {"name": "Alexander Street Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "1", "image": null},
    {"name": "Colonel Francis J. Beatty Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "2", "image": null},
    {"name": "Freedom Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "3", "image": null},
    {"name": "Hornets Nest Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "2", "image": null},
    {"name": "New Facility", "location": "New Location", "surface": "Sand", "courts": "4", "image": null},
    {"name": "HOA", "location": "Fort Mill", "surface": "Sand", "courts": "6", "image": null},
  ];

  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage(int index) async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        facilities[index]["image"] = pickedImage.path; // Update the image path in the list
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Facilities"),
      ),
      body: ListView.builder(
        itemCount: facilities.length,
        itemBuilder: (context, index) {
          final facility = facilities[index];
          return ListTile(
            leading: GestureDetector(
              onTap: () {
                _pickImage(index); // Trigger the image picker
              },
              child: facility["image"] == null
                  ? Icon(Icons.add_photo_alternate, size: 50)
                  : Image.file(
                File(facility["image"]!),
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
            title: Text(facility["name"]!),
            subtitle: Text(
                "${facility["location"]!} - Surface: ${facility["surface"]!} - Courts: ${facility["courts"]!}"),
          );
        },
      ),
    );
  }
}
