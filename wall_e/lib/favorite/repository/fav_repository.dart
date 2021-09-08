import 'package:wall_e/favorite/data_provider/data_provider.dart';
import 'package:wall_e/favorite/models/fav_model.dart';

class FavRepository {
  final FavDataProvider favDataProvider;

  FavRepository({required this.favDataProvider});

  Future<List> getFavoriteImages(String username) async {
    var result = await favDataProvider.getFavoriteImages(username);

    return result;
  }

  Future<String> deleteFavorite(RemoveFromFavoritesModel removeFromFavoritesModel) async {
    var result = await favDataProvider.deleteFavorite(removeFromFavoritesModel);

    return result;
  }

  Future<String> DownloadImage(String imageURL) async {
    var result = await favDataProvider.DownloadImage(imageURL);

    return result;
  }
}
