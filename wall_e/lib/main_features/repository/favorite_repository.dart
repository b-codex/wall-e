import 'package:wall_e/main_features/data_provider/favorite_data_provider.dart';

class FavoriteRepository {
  final FavoriteDataProvider favoriteDataProvider;
  FavoriteRepository({required this.favoriteDataProvider});

  Future<String> AddImageToFavorites(String username, String imageURL) async {
    print('my repo');
    var result =
        await favoriteDataProvider.AddImageToFavorites(username, imageURL);

    print(result);
    if (result == "Added To Favorites") {
      return "Success";
    } else {
      return "Failure";
    }
  }
}
