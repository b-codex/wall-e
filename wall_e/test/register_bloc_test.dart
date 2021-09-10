import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/auth/register/blocs/blocs.dart';
import 'package:wall_e/auth/register/models/register_model.dart';
import 'package:wall_e/auth/register/repository/register_repository.dart';

class MockRegisterRepository extends Mock implements RegisterRepository {}

void main() {
  final MockRegisterRepository mockRegisterRepository =
      MockRegisterRepository();

  blocTest<RegisterBloc, RegisterState>(
    "should emit [RegisterProgress]",
    build: () => RegisterBloc(registerRepository: mockRegisterRepository),
    act: (bloc) => bloc.add(
      AttemptRegister(
        user: RegisterUserModel(
          username: 'username',
          password: 'password',
          fullname: 'fullname',
          secretKey: '123456',
        ),
      ),
    ),
    expect: () => [
      RegisterProgress(),
    ],
  );
}
