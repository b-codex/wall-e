class SavePersonalInfoModel {
  final String fullname;
  final String username;
  final String password;

  SavePersonalInfoModel(
      {required this.fullname, required this.username, required this.password});
}

class ChangePasswordModel {
  final String username;
  final String password;
  final String secret_key;

  ChangePasswordModel({
    required this.username,
    required this.password,
    required this.secret_key,
  });
}
