import 'package:dio/dio.dart';
import 'package:wall_e/home_page/models/home_page_models.dart';

class HomePageProvider {
  Future<List> LoadImages() async {
    var response = await Dio().get('http://10.0.2.2:69/walls?start=1&end=100');
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
    var response = await Dio().get('http://10.0.2.2:69/walls?start=$start&end=$end');
    if (response.data['status'] == "") {
      return response.data['files'];
    } else {
      return ["Failure"];
    }
  }
}
