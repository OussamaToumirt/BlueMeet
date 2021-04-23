class UserDetailsModel {
  String status;
  String userId;
  String name;
  String email;
  Null phone;
  String gender;
  String isAuthorized;
  Null joinDate;
  String lastLogin;

  UserDetailsModel(
      {this.status,
        this.userId,
        this.name,
        this.email,
        this.phone,
        this.gender,
        this.isAuthorized,
        this.joinDate,
        this.lastLogin});

  UserDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    gender = json['gender'];
    isAuthorized = json['is_authorized'];
    joinDate = json['join_date'];
    lastLogin = json['last_login'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    data['is_authorized'] = this.isAuthorized;
    data['join_date'] = this.joinDate;
    data['last_login'] = this.lastLogin;
    return data;
  }
}