import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/profile/blocs/blocs.dart';
import 'package:wall_e/profile/repository/profile_repository.dart';
import 'package:wall_e/sharedPreference.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository profileRepository;
  ProfileBloc({required this.profileRepository}) : super(IdleProfileState());

  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is LoadProfileEvent) {
      yield LoadingProfileState();

      final _prefs = sharedPreference();
      late String username;
      await _prefs.getUsername().then((value) {
        username = value;
      });

      var response = await profileRepository.getPersonalInfo(username)
          as Map<dynamic, dynamic>;

      await Future.delayed(Duration(seconds: 1));

      yield ProfileLoadedState(
          fullname: response['fullname'],
          username: response['username'],
          password: response['password']);
    }
    if (event is SaveProfileEvent) {
      // Save Profile
      var response = await profileRepository.savePersonalInfo(
          event.fullname, event.username, event.password);

      if (response == 'Success') {
        yield SavedProfileState();
      } else {
        yield FailedToSaveProfileState();
      }
    }
    if (event is ChangePassword) {
      var response = await profileRepository.changePassword(
        event.username,
        event.password,
        event.secret_key,
      );

      if (response == 'Success') {
        yield PasswordChangedState();
      } else {
        yield PasswordFailedToChangeState();
      }
    }

    if (event is DeleteAccount) {
      var response = await profileRepository.deleteAccount(event.username);

      if (response == 'Success') {
        yield AccountDeleted();
      }
    }
  }
}
