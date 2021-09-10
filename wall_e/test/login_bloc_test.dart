import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/auth/login/blocs/blocs.dart';
import 'package:wall_e/auth/login/models/login_model.dart';
import 'package:wall_e/auth/login/repository/login_repository.dart';

class MockLoginRepository extends Mock implements LoginRepository {}

void main() {
  final MockLoginRepository mockLoginRepository = MockLoginRepository();

  blocTest<LoginBloc, LoginState>(
    "should emit [CheckStatus]",
    build: () => LoginBloc(loginRepository: mockLoginRepository),
    expect: () => [],
  );

  blocTest<LoginBloc, LoginState>(
    "should emit [CheckingStatus, LoggedOut]",
    build: () => LoginBloc(loginRepository: mockLoginRepository),
    act: (bloc) => bloc.add(CheckLoginStatus()),
    expect: () => [CheckingStatus(), LoggedOut()],
  );

  blocTest<LoginBloc, LoginState>(
    "should emit [LoginProgress]",
    build: () => LoginBloc(loginRepository: mockLoginRepository),
    act: (bloc) => bloc.add(
      AttemptLogin(
        user: LoginUserModel(username: 'username', password: 'password'),
      ),
    ),
    expect: () => [
      LoginProgress(),
    ],
  );
  
}