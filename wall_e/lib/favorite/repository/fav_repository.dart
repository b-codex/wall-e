import 'package:wall_e/favorite/data_provider/data_provider.dart';

class FavRepository {
  final FavDataProvider favDataProvider;

  FavRepository({required this.favDataProvider});

  Future<List> getFavoriteImages(String username) async {
    var result = await favDataProvider.getFavoriteImages(username);

    return result;
  }

  Future<String> deleteFavorite(String username, String imageURL) async {
    var result = await favDataProvider.deleteFavorite(username, imageURL);

    return result;
  }

  Future<String> DownloadImage(String imageURL) async {
    var result = await favDataProvider.DownloadImage(imageURL);

    return result;
  }
}
