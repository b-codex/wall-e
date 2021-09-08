import 'package:wall_e/main_features/data_provider/favorite_data_provider.dart';
import 'package:wall_e/main_features/models/favorite_model.dart';

class FavoriteRepository {
  final FavoriteDataProvider favoriteDataProvider;
  FavoriteRepository({required this.favoriteDataProvider});

  Future<String> AddImageToFavorites(FavoriteModel favoriteModel) async {
    var result =
        await favoriteDataProvider.AddImageToFavorites(favoriteModel);

    if (result == "Added To Favorites") {
      return "Success";
    } else {
      return "Failure";
    }
  }
}
