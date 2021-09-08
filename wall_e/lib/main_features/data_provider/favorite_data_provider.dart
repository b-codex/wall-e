import 'package:dio/dio.dart';
import 'package:wall_e/main_features/models/favorite_model.dart';

class FavoriteDataProvider {
  Future<Object> AddImageToFavorites(FavoriteModel favoriteModel) async {
    String username = favoriteModel.username;
    String imageURL = favoriteModel.imageURL;
    var response = await Dio()
        .put('http://10.0.2.2:69/addFavorite?username=$username&url=$imageURL');
    if (response.data['status'] == '') {
      return "Added To Favorites";
    } else {
      return "Failed To Add To Favorites";
    }
  }
}
