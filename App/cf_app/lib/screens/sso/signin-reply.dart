class UserCollection {
  final bool? success;
  final String? status;
  final String? email;
  final String? token;

  UserCollection({this.success, this.status, this.email, this.token});

  factory UserCollection.fromJson(Map<String, dynamic> json) {
    return UserCollection(
        success: json['success'] as bool,
        email: json['email'] as String,
        token: json['token'] as String,
        status: json['status'] as String);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['email'] = this.email;
    data['token'] = this.token;
    return data;
  }
}
