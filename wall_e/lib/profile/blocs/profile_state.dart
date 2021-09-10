import 'package:equatable/equatable.dart';

abstract class ProfileState extends Equatable {}

class IdleProfileState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class ProfileLoadedState extends ProfileState {
  final String fullname;
  final String username;
  final String password;

  ProfileLoadedState({
    required this.fullname,
    required this.username,
    required this.password,
  });
  @override
  List<Object?> get props => [];
}

class ProfileFailedToLoadState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class LoadingProfileState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class SavedProfileState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class FailedToSaveProfileState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class PasswordChangedState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class PasswordFailedToChangeState extends ProfileState {
  @override
  List<Object?> get props => [];
}

class AccountDeleted extends ProfileState {
  @override
  List<Object?> get props => [];
}
