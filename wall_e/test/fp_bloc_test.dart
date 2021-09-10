import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/auth/forgot_password/blocs/blocs.dart';
import 'package:wall_e/auth/forgot_password/models/fp_model.dart';
import 'package:wall_e/auth/forgot_password/repository/fp_repository.dart';

class MockFPRepository extends Mock implements FP_Repository {}

void main() {
  final MockFPRepository mockFPRepository = MockFPRepository();

  blocTest<FP_Bloc, FP_State>(
    "should emit [ResetIdle]",
    build: () => FP_Bloc(fp_repository: mockFPRepository),
    expect: () => [],
  );

  blocTest<FP_Bloc, FP_State>(
    "should emit [ResetProgress]",
    build: () => FP_Bloc(fp_repository: mockFPRepository),
    act: (bloc) => bloc.add(
      AttemptReset(
        fp_model: FP_Model(
          username: 'username',
          password: 'password',
          secretKey: 'secretKey',
        ),
      ),
    ),
    expect: () => [ResetProgress()],
  );
}