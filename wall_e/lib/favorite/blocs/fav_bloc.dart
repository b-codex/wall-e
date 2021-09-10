import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';
import 'package:wall_e/favorite/models/fav_model.dart';
import 'package:wall_e/favorite/repository/fav_repository.dart';
import 'package:wall_e/sharedPreference.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final FavRepository favRepository;

  FavBloc({required this.favRepository}) : super(InitialState());

  @override
  Stream<FavState> mapEventToState(FavEvent event) async* {
    final _prefs = sharedPreference();
    late String username;
    await _prefs.getUsername().then((value) => username = value);

    if (event is IdleEvent) {
      yield InitialState();
    }

    if (event is LoadFavoriteImagesEvent) {
      await Future.delayed(Duration(seconds: 2));

      var response = await favRepository.getFavoriteImages(username);

      if (response.length == 0) {
        yield LoadDoneState(images: response);
      }

      if (response.length != 0) {
        if (response[0] == "API Error") {
          yield LoadFailedState(errorMessage: 'API Error');
        } else {
          yield LoadDoneState(images: response);
          // await Future.delayed(Duration(seconds: 5));
          // yield InitialState();
        }
      }
    }

    if (event is DownloadImage) {
      var response = await favRepository.DownloadImage(event.imageUrl);
      if (response == "Success") {
        yield DownloadImageDone();
      }
      if (response == "Failure") {
        yield DownloadImageFailed(errorMessage: response);
      }
    }

    if (event is RemoveFromFavoritesEvent) {
      var response = await favRepository.deleteFavorite(
          RemoveFromFavoritesModel(
              username: username, imageURL: event.imageURL));

      if (response == "Success") {
        yield RemovedFromFavorite();
        yield InitialState();
      }
      if (response == "Failure") {
        yield InitialState();
      }
    }
  }
}
