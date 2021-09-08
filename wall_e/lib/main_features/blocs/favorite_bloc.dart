import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/main_features/blocs/favorite_event.dart';
import 'package:wall_e/main_features/blocs/favorite_state.dart';
import 'package:wall_e/main_features/models/favorite_model.dart';
import 'package:wall_e/main_features/repository/favorite_repository.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository favoriteRepository;

  FavoriteBloc({required this.favoriteRepository}) : super(NotFavorite());

  @override
  Stream<FavoriteState> mapEventToState(FavoriteEvent event) async* {
    if (event is AddToFavoritesEvent) {
      final response = await favoriteRepository.AddImageToFavorites(
          FavoriteModel(username: event.username, imageURL: event.imageURL));
      if (response == 'Success') {
        yield SavedAsFavorite();
      } else {
        yield NotFavorite();
      }
    }
  }
}
