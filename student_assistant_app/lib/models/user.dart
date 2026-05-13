/*
 * Student Numbers: 224022456, 224111760, 223089499, 223082118, 224107046, 223086046, 220025661, 224090026
 * Student Names  : Musa Bonga, Sibusiso Lukhele, Noluthando Ndebele, Nombulelo Menyuka, Siphosethu Mbasa, Luyanda P Mtungwa, Tiarina Jean Iye, Kamohelo Tlotliso Junior Phatsoane
 * Group          : GROUP_H1
 * Subject        : Technical Programming III (TPG316C)
 */

class User {
  final String username;
  final String password;

  User({required this.username, required this.password});
}

//Took from Unit 5 just testing something- 224090026
class Student {
  final String id;
  final String name;
  final String phone;
  final String? profilePictureUrl;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;
  Student({
    required this.id,
    required this.name,
    required this.phone,
    this.profilePictureUrl,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });
  // Convert JSON → Student (from Supabase)
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['id'].toString(),
      name: json['name'] ?? '',
      phone: json['phone'] ?? '',
      profilePictureUrl: json['profile_picture_url'],
      userId: json['user_id'].toString(),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
  // Convert Student → JSON (for Supabase)
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      if (profilePictureUrl != null) 'profile_picture_url': profilePictureUrl,
    };
  }
}
