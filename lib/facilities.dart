import 'package:flutter/material.dart';

class FacilitiesPage extends StatelessWidget {
  final List<Map<String, String>> facilities = [
    {"name": "Sand Court A", "location": "Los Angeles", "surface": "Sand", "courts": "2"},
    {"name": "Grass Field B", "location": "Chicago", "surface": "Grass", "courts": "1"},
    {"name": "Indoor Arena C", "location": "New York", "surface": "Indoor", "courts": "3"},
    {"name": "Dale F. Halton Arena", "location": "Charlotte, NC", "surface": "Indoor", "courts": "5"},
    {"name": "Carolina Volleyball Center", "location": "Columbia, SC", "surface": "Indoor", "courts": "4"},
    {"name": "Northlake Sports Center", "location": "Charlotte, NC", "surface": "Indoor", "courts": "6"},
    {"name": "The Sandbox", "location": "Charlotte, NC", "surface": "Sand", "courts": "3"},
    {"name": "Thirsty Social Club", "location": "Belmont, NC", "surface": "Sand", "courts": "2"},
    {"name": "Carolina CHAOS Volleyball Club", "location": "1281 Biscayne Dr., Concord, NC", "surface": "Indoor", "courts": "2"},
    {"name": "Abbey's Academy Inc.", "location": "Charlotte, NC", "surface": "Indoor", "courts": "1"},
    {"name": "Sports Connection", "location": "Charlotte, NC", "surface": "Indoor", "courts": "4"},
    {"name": "Alexander Street Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "1"},
    {"name": "Colonel Francis J. Beatty Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "2"},
    {"name": "Freedom Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "3"},
    {"name": "Hornets Nest Park", "location": "Charlotte, NC", "surface": "Outdoor", "courts": "2"},
    {"name": "New Facility", "location": "New Location", "surface": "Sand", "courts": "4"},
    {"name": "HOA", "location": "Fort Mill", "surface": "Sand", "courts": "6"},
  ];

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
            title: Text(facility["name"]!),
            subtitle: Text(
                "${facility["location"]!} - Surface: ${facility["surface"]!} - Courts: ${facility["courts"]!}"),
          );
        },
      ),
    );
  }
}
