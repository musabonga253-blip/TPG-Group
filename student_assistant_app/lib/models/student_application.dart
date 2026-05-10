class StudentApplication {
  final int id;
  final String studentName;
  final String yearOfStudy;
  final String module1;
  final String? module2;
  String status; // Pending, Approved, Rejected

  StudentApplication({
    required this.id,
    required this.studentName,
    required this.yearOfStudy,
    required this.module1,
    this.module2,
    this.status = "Pending",
  });
}
