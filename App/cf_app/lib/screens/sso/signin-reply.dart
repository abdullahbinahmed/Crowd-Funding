import 'dart:convert';

import './model.dart';

class UserCollection {
  final bool? success;
  final String? status;
  final String? email;
  final String? token;
  final User? user;
  final String? firstname;
  final String? lastname;

  UserCollection(
      {this.success,
      this.status,
      this.email,
      this.token,
      this.user,
      this.firstname,
      this.lastname});

  factory UserCollection.fromJson(Map<String, dynamic> json) {
    return UserCollection(
        success: json['success'] as bool,
        email: json['email'] as String,
        token: json['token'] as String,
        status: json['status'] as String,
        user: json['user'] == null ? null : User.fromJson(json['user']),
        firstname: json['firstname'] as String,
        lastname: json['lastname'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['email'] = this.email;
    data['token'] = this.token;
    data['user'] = this.user;
    data['lastname'] = this.lastname;
    data['firstname'] = this.firstname;
    return data;
  }
}
