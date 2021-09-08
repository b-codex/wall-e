abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {}

class SaveProfileEvent extends ProfileEvent {
  final String fullname;
  final String username;
  final String password;

  SaveProfileEvent(
      {required this.fullname, required this.username, required this.password});
}

class ChangePassword extends ProfileEvent {
  final String username;
  final String password;
  final String secret_key;

  ChangePassword({
    required this.username,
    required this.password,
    required this.secret_key,
  });
}

class DeleteAccount extends ProfileEvent {
  final String username;

  DeleteAccount({required this.username});
}
