import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/profile/blocs/blocs.dart';
import 'package:wall_e/profile/repository/profile_repository.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  final MockProfileRepository mockProfileRepository = MockProfileRepository();

  test('initial state is IdleProfileState', () {
    var currentState = ProfileBloc(profileRepository: mockProfileRepository);
    expect(IdleProfileState(), currentState.state);
  });

}
