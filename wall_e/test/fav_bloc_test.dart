import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';
import 'package:wall_e/favorite/repository/fav_repository.dart';

class MockFavRepository extends Mock implements FavRepository {}

void main() {
  MockFavRepository mockFavRepository = MockFavRepository();

  blocTest<FavBloc, FavState>(
    "should emit [IdleState]",
    build: () => FavBloc(favRepository: mockFavRepository),
    expect: () => [],
  );

  blocTest<FavBloc, FavState>(
    'should emit [DownloadImage]',
    build: () => FavBloc(favRepository: mockFavRepository),
    act: (bloc) {
      bloc.add(DownloadImage(imageUrl: 'imageUrl'));
    },
    expect: () => [],
  );

  test('initial state is IdleState', () {
    var currentState = FavBloc(favRepository: mockFavRepository);
    expect(IdleState(), currentState.state);
  });

  // test('should emit [DownloadImageFailed]', () async {
  //   var currentState = FavBloc(favRepository: mockFavRepository);

  //   currentState.add(DownloadImage(imageUrl: 'imageUrl'));
  //   // currentState.emit(DownloadImageFailed(errorMessage: 'errorMessage'));

  //   expect(
  //       DownloadImageFailed(errorMessage: 'errorMessage'), currentState.state);
  // });

  blocTest<FavBloc, FavState>(
    'should emit [DownloadImageFailed]',
    build: () => FavBloc(favRepository: mockFavRepository),
    act: (bloc) => bloc.add(DownloadImage(imageUrl: 'imageUrl')),
    expect: () {
      return DownloadImageDone();
    },
  );

  test(
    'OLD WAY emits [WeatherLoading, WeatherLoaded] when successful',
    () {
      when(mockFavRepository.DownloadImage('imageURL'));
      final bloc = FavBloc(favRepository: mockFavRepository);
      bloc.add(DownloadImage(imageUrl: ''));
      expectLater(
        bloc,
        emitsInOrder([DownloadImageFailed(errorMessage: 'errorMessage')]),
      );
    },
  );
}