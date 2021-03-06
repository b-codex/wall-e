import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wall_e/favorite/models/fav_model.dart';

class FavDataProvider {
  Future<List> getFavoriteImages(String username) async {
    try {
      var response = await Dio(BaseOptions(
        connectTimeout: 5 * 1000,
      )).get('http://10.0.2.2:69/getFavorite?username=$username');

      if (response.data['status'] == '') {
        if (response.data['files'] != null) {
          return response.data['files'];
        }
        return [];
      } else {
        return [];
      }
    } on DioError catch (_) {
      return ['API Error'];
    }
  }

  Future<String> deleteFavorite(
      RemoveFromFavoritesModel removeFromFavoritesModel) async {
    try {
      String username = removeFromFavoritesModel.username;
      String imageURL = removeFromFavoritesModel.imageURL;
      var response = await Dio().put(
          'http://10.0.2.2:69/deleteFavorite?username=$username&url=$imageURL');
      if (response.data['status'] == '') {
        return 'Success';
      } else {
        return 'Failure';
      }
    } on DioError catch (_) {
      return 'API Error';
    }
  }

  Future<String> DownloadImage(String imageURL) async {
    Random random = new Random();
    int randomNumber = random.nextInt(9999999);

    var response = await Dio().get(
      imageURL,
      options: Options(
        responseType: ResponseType.bytes,
      ),
    );

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: randomNumber.toString());

    if (result['isSuccess']) {
      return "Success";
    } else {
      return "Failure";
    }
  }
}
