

class UserModel {
  String email;
  String password;

  UserModel({required this.email, required this.password});

  // Convert a UserModel into a Map<String, dynamic> for JSON encoding
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  // Convert a Map<String, dynamic> into a UserModel
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      email: json['email'],
      password: json['password'],
    );
  }
}
