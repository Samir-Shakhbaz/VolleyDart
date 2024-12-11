import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class FacilityDetailsPage extends StatefulWidget {
  final Map<String, String?> facility;

  FacilityDetailsPage({required this.facility});

  @override
  _FacilityDetailsPageState createState() => _FacilityDetailsPageState();
}

class _FacilityDetailsPageState extends State<FacilityDetailsPage> {
  final ImagePicker picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        widget.facility["image"] = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.facility["name"] ?? "Facility Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                width: double.infinity,
                height: 200,
                color: Colors.grey[300],
                child: widget.facility["image"] == null
                    ? Icon(Icons.add_photo_alternate, size: 50, color: Colors.grey[700])
                    : Image.file(
                  File(widget.facility["image"]!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text("Name: ${widget.facility["name"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Location: ${widget.facility["location"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Surface: ${widget.facility["surface"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Courts: ${widget.facility["courts"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Organization: ${widget.facility["organization"] ?? 'N/A'}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text("Rental: ${widget.facility["rental"] ?? 'N/A'}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            widget.facility["website"] != null
                ? GestureDetector(
              onTap: () {
                // Open website in browser (if URL is valid)
                final url = widget.facility["website"]!;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Opening $url")),
                );
                // You can use url_launcher package to open URL
              },
              child: Text(
                "Website: ${widget.facility["website"]}",
                style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            )
                : Text("Website: N/A", style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
