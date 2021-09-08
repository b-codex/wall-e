import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/profile/blocs/blocs.dart';
import 'package:wall_e/profile/models/profile_models.dart';
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

      if (response['status'] == 'Success') {
        yield ProfileLoadedState(
          fullname: response['fullname'],
          username: response['username'],
          password: response['password'],
        );
      } else {
        yield ProfileFailedToLoadState();
      }
    }
    if (event is SaveProfileEvent) {
      // Save Profile
      var response = await profileRepository.savePersonalInfo(
        SavePersonalInfoModel(
          fullname: event.fullname,
          username: event.username,
          password: event.password,
        ),
      );

      if (response == 'Success') {
        yield SavedProfileState();
      } else {
        yield FailedToSaveProfileState();
      }
    }
    if (event is ChangePassword) {
      var response = await profileRepository.changePassword(
        ChangePasswordModel(
          username: event.username,
          password: event.password,
          secret_key: event.secret_key,
        ),
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
