import 'package:hive/hive.dart';
part 'user_model.g.dart';
@HiveType(typeId: 3)
class AuthUser {
  @HiveField(0)
  final status;
  @HiveField(1)
  final userId;
  @HiveField(2)
  final name;
  @HiveField(3)
  final email;
  @HiveField(4)
  final phone;
  @HiveField(5)
  final meetingCode;
  @HiveField(6)
  final imageUrl;
  @HiveField(7)
  final gender;
  @HiveField(8)
  final role;
  @HiveField(9)
  final joinDate;
  @HiveField(10)
  final lastLogin;

  AuthUser(
      {this.status,
      this.userId,
      this.name,
      this.email,
      this.phone,
      this.meetingCode,
      this.imageUrl,
      this.gender,
      this.role,
      this.joinDate,
      this.lastLogin});

  factory AuthUser.fromJson(Map<String, dynamic> json) {
    return AuthUser(
      status: json['status'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      meetingCode: json['meeting_code'],
      imageUrl: json['image_url'],
      gender: json['gender'],
      role: json['role'],
      joinDate: json['join_date'],
      lastLogin: json['last_login'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['meeting_code'] = this.meetingCode;
    data['image_url'] = this.imageUrl;
    data['gender'] = this.gender;
    data['role'] = this.role;
    data['join_date'] = this.joinDate;
    data['last_login'] = this.lastLogin;
    return data;
  }
}
