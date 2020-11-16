class User {
  final int idusers;
  final String fullname;
  final String email;
  final int module;
  final String role;
  final String token;
  final String refreshToken;

  User(
      {this.idusers,
      this.fullname,
      this.email,
      this.module,
      this.role,
      this.token,
      this.refreshToken});

  Map<String, dynamic> toMap() {
    return {
      'id': idusers,
      'fullname': fullname,
      'email': email,
      'module': module,
      'role': role,
      'token': token,
      'refreshToken': refreshToken,
    };
  }

  @override
  String toString() {
    return 'User{idusers: $idusers, fullname: $fullname, email: $email,module: $module,role: $role,token: $token,refreshToken: $refreshToken}';
  }
}
