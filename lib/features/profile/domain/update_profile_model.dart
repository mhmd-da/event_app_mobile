class UpdateProfile {
  final int id;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? bio;
  final String? university;
  final String? department;
  final String? major;

  UpdateProfile({
    required this.id,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.university,
    required this.department,
    required this.major,
  });
}