import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/profile/blocs/blocs.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(IdleProfileState());
  @override
  Stream<ProfileState> mapEventToState(ProfileEvent event) async* {
    if (event is SaveProfileEvent) {
      // Save Profile
    }
  }
}
