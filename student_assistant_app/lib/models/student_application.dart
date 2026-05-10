/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

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
    this.status = 'Pending',
  });

  StudentApplication copyWith({
    int? id,
    String? studentName,
    String? yearOfStudy,
    String? module1,
    String? module2,
    String? status,
  }) {
    return StudentApplication(
      id: id ?? this.id,
      studentName: studentName ?? this.studentName,
      yearOfStudy: yearOfStudy ?? this.yearOfStudy,
      module1: module1 ?? this.module1,
      module2: module2 ?? this.module2,
      status: status ?? this.status,
    );
  }
}