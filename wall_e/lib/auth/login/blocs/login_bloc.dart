import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/auth/login/blocs/blocs.dart';
import 'package:wall_e/auth/login/repository/login_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginRepository loginRepository;
  LoginBloc({required this.loginRepository}) : super(LoggedOut());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is AttemptLogin) {
      yield LoginProgress();
      await Future.delayed(Duration(seconds: 2));
      final response = await loginRepository.LoginUser(event.user);
      if (response == "Failure") {
        yield LoginFailure(
            message:
                'Login Failed. Please Check Your Credentials & Try Again.');
      }
      if (response == "Success") {
        yield LoggedIn();
      }
    }
  }
}
