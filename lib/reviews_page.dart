import 'package:flutter/material.dart';

class AllReviewsPage extends StatelessWidget {
  final List<Map<String, String>> allReviews;

  AllReviewsPage({required this.allReviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Reviews"),
      ),
      body: allReviews.isEmpty
          ? const Center(
        child: Text(
          "No reviews available.",
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      )
          : ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: allReviews.length,
        itemBuilder: (context, index) {
          final review = allReviews[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0),
            child: ListTile(
              title: Text(review["review"] ?? "No review"),
              subtitle: Text("Rating: ${review["rating"]} / 5"),
            ),
          );
        },
      ),
    );
  }
}
