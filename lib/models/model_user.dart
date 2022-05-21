class User {
  final String? displayName;
  final String? loginName;
  final String? userRole;
  final String? email;

  final int? statusCode;
  final bool? success;
  final String? message;

  const User(
      {this.displayName,
        this.loginName,
        this.userRole,
        this.email,
        this.success,
        this.statusCode,
        this.message});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      displayName: json['display_name'],
      loginName: json['username'],
      userRole: json['user_role'],
      email: json['email'],
      success: json['Success'],
      statusCode: json['StatusCode'],
      message: json['Message'],
    );
  }
}