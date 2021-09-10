import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/auth/login/blocs/blocs.dart';
import 'package:wall_e/auth/login/repository/login_repository.dart';
import 'package:wall_e/sharedPreference.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(CheckStatus());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is CheckLoginStatus) {
      yield CheckingStatus();

      await Future.delayed(Duration(milliseconds: 800));

      final _prefs = sharedPreference();
      bool status = false;

      await _prefs.getUsername().then(
        (value) {
          if (value != null) {
            status = true;
          }
        },
      );

      if (status) {
        yield LoggedIn();
      } else {
        yield LoggedOut();
      }
    }

    if (event is AttemptLogin) {
      yield LoginProgress();

      await Future.delayed(Duration(milliseconds: 1000));

      final response = await loginRepository.LoginUser(event.user);
      if (response == "Failure") {
        yield LoginFailure(
          message: 'Login Failed. Please Check Your Credentials & Try Again.',
        );
        yield CheckStatus();
      }
      if (response == "Success") {
        yield LoggedIn();
      }
    }
  }
}
