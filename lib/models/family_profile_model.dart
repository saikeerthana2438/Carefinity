class FamilyProfileModel {
  final String id;
  final String name;
  final String relationship;
  final int age;
  final String gender;
  final String bloodGroup;

  FamilyProfileModel({
    required this.id,
    required this.name,
    required this.relationship,
    required this.age,
    required this.gender,
    required this.bloodGroup,
  });

  factory FamilyProfileModel.fromMap(Map<String, dynamic> map) {
    return FamilyProfileModel(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      relationship: map['relationship'] ?? '',
      age: map['age'] ?? 0,
      gender: map['gender'] ?? '',
      bloodGroup: map['blood_group'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'relationship': relationship,
      'age': age,
      'gender': gender,
      'blood_group': bloodGroup,
    };
  }
}