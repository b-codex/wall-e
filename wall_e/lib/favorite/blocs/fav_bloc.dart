import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';
import 'package:wall_e/favorite/models/fav_model.dart';
import 'package:wall_e/favorite/repository/fav_repository.dart';
import 'package:wall_e/sharedPreference.dart';

class FavBloc extends Bloc<FavEvent, FavState> {
  final FavRepository favRepository;

  FavBloc({required this.favRepository}) : super(IdleState());

  @override
  Stream<FavState> mapEventToState(FavEvent event) async* {
    final _prefs = sharedPreference();
    late String username;
    await _prefs.getUsername().then((value) => username = value);

    if (event is LoadingFavoriteImagesEvent) {
      var response = await favRepository.getFavoriteImages(username);
      
      if (response.length == 0) {
        yield LoadDone(images: response);
      }
      if (response.length != 0) {
        if (response[0] == "API Error") {
          yield LoadFailed(errorMessage: 'API Error');
        } else {
          yield LoadDone(images: response);
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
        yield IdleState();
      }
      if (response == "Failure") {
        yield IdleState();
      }
    }
  }
}
