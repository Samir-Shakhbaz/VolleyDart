import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:volley_app/reviews_page.dart';
import 'claim_your_employer_profile_page.dart';
import 'map_package.dart'; // Updated MapPage with dynamic geocoding

class FacilityDetailsPage extends StatefulWidget {
  final Map<String, String?> facility;

  FacilityDetailsPage({required this.facility});

  @override
  _FacilityDetailsPageState createState() => _FacilityDetailsPageState();
}

class _FacilityDetailsPageState extends State<FacilityDetailsPage> {
  final ImagePicker picker = ImagePicker();
  final List<Map<String, String>> reviews = [];
  double ratingSum = 0.0;
  int ratingCount = 0;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        widget.facility["image"] = pickedImage.path;
      });
    }
  }

  void _addReview(String review, double rating) {
    setState(() {
      reviews.add({"review": review, "rating": rating.toString()});
      ratingSum += rating;
      ratingCount++;
    });
  }

  @override
  Widget build(BuildContext context) {
    double averageRating = ratingCount == 0 ? 0.0 : (ratingSum / ratingCount);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.facility["name"] ?? "Facility Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
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

            // Facility Details
            Text("Name: ${widget.facility["name"]}", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),

            Text("Location: ${widget.facility["location"]}", style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),

            ElevatedButton(
              onPressed: () {
                final location = widget.facility["location"];
                if (location != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MapPage(location: location), // Pass dynamic location
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Location not available!")),
                  );
                }
              },
              child: const Text("Show on Map"),
            ),
            SizedBox(height: 16),

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
                final url = widget.facility["website"]!;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text("Opening $url")),
                );
              },
              child: Text(
                "Website: ${widget.facility["website"]}",
                style: TextStyle(fontSize: 18, color: Colors.blue, decoration: TextDecoration.underline),
              ),
            )
                : Text("Website: N/A", style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),

            // Ratings Section
            Text(
              "Average Rating: ${averageRating.toStringAsFixed(1)} / 5",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),

            // Reviews Section
            Text(
              "Reviews",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ...reviews.map((review) {
              return ListTile(
                title: Text(review["review"]!),
                subtitle: Text("Rating: ${review["rating"]} / 5"),
              );
            }).toList(),

            // Add Review Button
            ElevatedButton(
              onPressed: _showReviewDialog,
              child: Text("Add a Review"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllReviewsPage(allReviews: reviews),
                  ),
                );
              },
              child: const Text("View All Reviews"),
            ),

            SizedBox(height: 20),

            // Claim Profile Button
            Center(
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ClaimProfilePage(),
                    ),
                  );
                },
                child: Text(
                  "Work here? Claim your free employer profile",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showReviewDialog() {
    final TextEditingController reviewController = TextEditingController();
    double selectedRating = 3.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add a Review"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: reviewController,
                    decoration: const InputDecoration(labelText: "Review"),
                  ),
                  SizedBox(height: 10),
                  Text("Rating: ${selectedRating.toStringAsFixed(1)}"),
                  Slider(
                    min: 1,
                    max: 5,
                    value: selectedRating,
                    divisions: 4,
                    label: selectedRating.toString(),
                    onChanged: (value) {
                      setState(() {
                        selectedRating = value;
                      });
                    },
                  ),
                ],
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                _addReview(reviewController.text, selectedRating);
                Navigator.pop(context);
              },
              child: const Text("Submit"),
            ),
          ],
        );
      },
    );
  }
}
