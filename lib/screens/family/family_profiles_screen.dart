import 'package:flutter/material.dart';

import '../../models/family_profile_model.dart';
import '../../services/family_profile_service.dart';

class FamilyProfilesScreen extends StatefulWidget {
  const FamilyProfilesScreen({super.key});

  @override
  State<FamilyProfilesScreen> createState() =>
      _FamilyProfilesScreenState();
}

class _FamilyProfilesScreenState
    extends State<FamilyProfilesScreen> {

  final FamilyProfileService _service = FamilyProfileService();

  final nameController = TextEditingController();
  final ageController = TextEditingController();

  List<FamilyProfileModel> profiles = [];

  bool isLoading = true;

  String relationship = "Self";
  String gender = "Male";
  String bloodGroup = "O+";

  final relationships = [
    "Self",
    "Father",
    "Mother",
    "Brother",
    "Sister",
    "Son",
    "Daughter",
    "Grandfather",
    "Grandmother",
    "Other",
  ];

  final genders = [
    "Male",
    "Female",
    "Other",
  ];

  final bloodGroups = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-",
  ];

  @override
  void initState() {
    super.initState();
    loadProfiles();
  }

  @override
  void dispose() {
    nameController.dispose();
    ageController.dispose();
    super.dispose();
  }

  Future<void> loadProfiles() async {
  setState(() {
    isLoading = true;
  });

  final data = await _service.getProfiles();

  profiles = data
      .map((e) => FamilyProfileModel.fromMap(e))
      .toList();

  if (mounted) {
    setState(() {
      isLoading = false;
    });
  }
}
  Future<void> addProfile() async {
  if (nameController.text.trim().isEmpty ||
      ageController.text.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Please fill all fields."),
      ),
    );
    return;
  }

  try {
    await _service.addProfile(
      name: nameController.text.trim(),
      relationship: relationship,
      age: int.parse(ageController.text),
      gender: gender,
      bloodGroup: bloodGroup,
    );

    nameController.clear();
    ageController.clear();

    await loadProfiles();

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Family member added successfully."),
        ),
      );
    }
  } catch (e) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Family Profiles"),
      ),
      body: ListView(
  padding: const EdgeInsets.all(20),
  children: [
    Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Icon(
              Icons.family_restroom,
              size: 60,
              color: Colors.blue,
            ),
            const SizedBox(height: 10),
            const Text(
              "Family Profiles",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                labelText: "Member Name",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            TextField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Age",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: relationship,
              decoration: const InputDecoration(
                labelText: "Relationship",
                border: OutlineInputBorder(),
              ),
              items: relationships
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  relationship = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: gender,
              decoration: const InputDecoration(
                labelText: "Gender",
                border: OutlineInputBorder(),
              ),
              items: genders
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  gender = value!;
                });
              },
            ),

            const SizedBox(height: 15),

            DropdownButtonFormField<String>(
              value: bloodGroup,
              decoration: const InputDecoration(
                labelText: "Blood Group",
                border: OutlineInputBorder(),
              ),
              items: bloodGroups
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  bloodGroup = value!;
                });
              },
            ),

            const SizedBox(height: 20),

            FilledButton(
              onPressed: addProfile,
              child: const Padding(
                padding: EdgeInsets.all(15),
                child: Text("Add Family Member"),
              ),
            ),
          ],
        ),
      ),
    ),

    const SizedBox(height: 25),

    const Text(
      "Family Members",
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
      ),
    ),

    const SizedBox(height: 15),

    if (isLoading)
      const Center(
        child: CircularProgressIndicator(),
      )
    else if (profiles.isEmpty)
      const Card(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Center(
            child: Text("No family members added."),
          ),
        ),
      )
    else
      ...profiles.map(
        (member) => Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(member.name),
            subtitle: Text(
              "${member.relationship}\nAge: ${member.age} | ${member.gender}\nBlood Group: ${member.bloodGroup}",
            ),
            isThreeLine: true,
            trailing: IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () async {
  await _service.deleteProfile(member.id);
  await loadProfiles();
},
            ),
          ),
        ),
      ),
  ],
),
    );
  }
}