import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/main_features/blocs/favorite_bloc.dart';
import 'package:wall_e/main_features/blocs/favorite_state.dart';
import 'package:wall_e/main_features/repository/favorite_repository.dart';

class MockFavoriteBlocRepository extends Mock implements FavoriteRepository {}

void main() {
  final MockFavoriteBlocRepository mockFavoriteBlocRepository = MockFavoriteBlocRepository();

  test('initial state is NotFavorite', () {
    var currentState = FavoriteBloc(favoriteRepository: mockFavoriteBlocRepository);
    expect(NotFavorite(), currentState.state);
  });

}
