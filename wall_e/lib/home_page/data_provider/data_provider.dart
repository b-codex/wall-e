import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wall_e/home_page/models/home_page_models.dart';

class HomePageProvider {
  Future<List> LoadImages() async {
    var response = await Dio().get('http://10.0.2.2:69/walls?start=1&end=10');
    if (response.data['status'] == "") {
      return response.data['files'];
    } else {
      return ["Failure"];
    }
  }

  Future<List> LoadMoreImages(LoadMoreImagesModel loadMoreImagesModel) async {
    final int start = loadMoreImagesModel.start;
    final int end = loadMoreImagesModel.end;
    print('$start ================================= $end');
    var response =
        await Dio().get('http://10.0.2.2:69/walls?start=$start&end=$end');
    if (response.data['status'] == "") {
      return response.data['files'];
    } else {
      return ["Failure"];
    }
  }

  Future<Object> DownloadImage(String imageURL) async {
    Random random = new Random();
    int randomNumber = random.nextInt(9999999);

    var response = await Dio().get(
      imageURL,
      options: Options(responseType: ResponseType.bytes),
    );

    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: randomNumber.toString());
    return result;
  }
}
