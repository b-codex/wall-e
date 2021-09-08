abstract class ProfileState {}

class IdleProfileState extends ProfileState {}

class ProfileLoadedState extends ProfileState {
  final String fullname;
  final String username;
  final String password;

  ProfileLoadedState(
      {required this.fullname, required this.username, required this.password});
}

class ProfileFailedToLoadState extends ProfileState {}

class LoadingProfileState extends ProfileState {}

class SavedProfileState extends ProfileState {}

class FailedToSaveProfileState extends ProfileState {}

class PasswordChangedState extends ProfileState {}

class PasswordFailedToChangeState extends ProfileState {}

class AccountDeleted extends ProfileState {}
