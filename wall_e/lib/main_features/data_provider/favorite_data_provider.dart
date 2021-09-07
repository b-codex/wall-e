import 'package:dio/dio.dart';

class FavoriteDataProvider {
  Future<Object> AddImageToFavorites(String username, String imageURL) async {
    var response = await Dio().post(
        'http://10.0.2.2:69/addFavorite?username=$username&url=$imageURL');
    if (response.data['status'] == '') {
      return "Added To Favorites";
    } else {
      return "Failed To Add To Favorites";
    }
  }
}
