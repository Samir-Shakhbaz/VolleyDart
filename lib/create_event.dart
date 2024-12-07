import 'package:flutter/material.dart';
import 'global_events.dart';

class CreateEventPage extends StatefulWidget {
  @override
  _CreateEventPageState createState() => _CreateEventPageState();
}

class _CreateEventPageState extends State<CreateEventPage> {
  final _formKey = GlobalKey<FormState>();

  String? selectedLocation;
  String? newLocation;
  String? selectedSurfaceType;
  String? selectedFacility;
  String? newFacility;
  String? selectedSkillLevel;
  String? selectedGender;

  final List<String> locations = [
    "Los Angeles",
    "Chicago",
    "New York",
    "Charlotte, NC",
    "Columbia, SC",
    "Belmont, NC",
    "Concord, NC",
    "New Location"
  ];

  final List<String> surfaceTypes = ["Sand", "Grass", "Indoor", "Outdoor"];
  final List<String> facilities = ["Facility A", "Facility B", "New Facility"];
  final List<String> skillLevels = List.generate(13, (index) => (index + 1).toString());
  final List<String> genders = ["Male", "Female", "Coed", "Other"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Event Name"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the event name.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Dropdown for Location
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Location"),
                  value: selectedLocation,
                  items: locations.map((location) {
                    return DropdownMenuItem(value: location, child: Text(location));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a location.";
                    }
                    return null;
                  },
                ),

                if (selectedLocation == "New Location")
                  TextFormField(
                    decoration: const InputDecoration(labelText: "New Location Name"),
                    onChanged: (value) => newLocation = value,
                  ),
                const SizedBox(height: 16),

                // Dropdown for Surface Type
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Surface Type"),
                  value: selectedSurfaceType,
                  items: surfaceTypes.map((type) {
                    return DropdownMenuItem(value: type, child: Text(type));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSurfaceType = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a surface type.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Dropdown for Facility
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Facility"),
                  value: selectedFacility,
                  items: facilities.map((facility) {
                    return DropdownMenuItem(value: facility, child: Text(facility));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedFacility = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a facility.";
                    }
                    return null;
                  },
                ),

                if (selectedFacility == "New Facility")
                  TextFormField(
                    decoration: const InputDecoration(labelText: "New Facility Name"),
                    onChanged: (value) => newFacility = value,
                  ),
                const SizedBox(height: 16),

                // Dropdown for Skill Level
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Skill Level"),
                  value: selectedSkillLevel,
                  items: skillLevels.map((level) {
                    return DropdownMenuItem(value: level, child: Text(level));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedSkillLevel = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a skill level.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Dropdown for Gender
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Gender"),
                  value: selectedGender,
                  items: genders.map((gender) {
                    return DropdownMenuItem(value: gender, child: Text(gender));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please select a gender.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Team Size"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the team size.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Event Date"),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the event date.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  decoration: const InputDecoration(labelText: "Event Time"),
                  keyboardType: TextInputType.datetime,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter the event time.";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Add event creation logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Event created successfully")),
                      );
                    }
                  },
                  child: const Text("Add Event"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
