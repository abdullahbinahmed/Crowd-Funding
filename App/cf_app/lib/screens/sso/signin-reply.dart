import './model.dart';

class UserCollection {
  final bool? success;
  final String? status;
  final String? email;
  final String? token;
  final User? user;

  UserCollection(
      {this.success, this.status, this.email, this.token, this.user});

  factory UserCollection.fromJson(Map<String, dynamic> json) {
    return UserCollection(
        success: json['success'] as bool,
        email: json['email'] as String,
        token: json['token'] as String,
        status: json['status'] as String,
        user: json['user'] as User);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['email'] = this.email;
    data['token'] = this.token;
    data['user'] = this.user;
    return data;
  }
}
