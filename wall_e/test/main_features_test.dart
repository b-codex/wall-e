import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/main_features/blocs/blocs.dart';
import 'package:wall_e/main_features/repository/home_page_repository.dart';

class MockHomePageRepository extends Mock implements HomePageRepository {}

void main() {
  final MockHomePageRepository mockHomePageRepository = MockHomePageRepository();

  test('initial state is IdleState', () {
    var currentState = HomePageBloc(homePageRepository: mockHomePageRepository);
    expect(IdleState(), currentState.state);
  });

}
