import 'package:flutter/material.dart';

class ClaimProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController companyNameController = TextEditingController();
    final TextEditingController roleController = TextEditingController();
    final TextEditingController emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Claim Your Employer Profile"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Page Header
            const Text(
              "Claim Your Profile",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "Are you part of this organization? Take control of your profile to showcase your brand, respond to feedback, and engage with your audience.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),

            // Company Name Field
            TextField(
              controller: companyNameController,
              decoration: const InputDecoration(
                labelText: "Company Name",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Role Field
            TextField(
              controller: roleController,
              decoration: const InputDecoration(
                labelText: "Your Role at the Company",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 15),

            // Email Field
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: "Your Contact Email",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  final companyName = companyNameController.text;
                  final role = roleController.text;
                  final email = emailController.text;

                  if (companyName.isEmpty || role.isEmpty || email.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Please fill out all fields before submitting."),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Thank you! Your request to claim the profile for $companyName has been submitted."),
                      ),
                    );

                    // Clear fields after submission
                    companyNameController.clear();
                    roleController.clear();
                    emailController.clear();
                  }
                },
                child: const Text("Claim Your Profile Now"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
