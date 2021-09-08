class RegisterUserModel {
  final String fullname;
  final String username;
  final String password;
  final String secretKey;

  RegisterUserModel(
      {required this.fullname, required this.username, required this.password, required this.secretKey});
}
