import 'package:wall_e/home_page/data_provider/data_provider.dart';
import 'package:wall_e/home_page/models/home_page_models.dart';

class HomePageRepository {
  final HomePageProvider homePageProvider;
  HomePageRepository({required this.homePageProvider});

  Future<List> LoadImages() async {
    final result = await homePageProvider.LoadImages();
    return result;
  }

  Future<List> LoadMoreImages(LoadMoreImagesModel loadMoreImagesModel) async {
    final result = await homePageProvider.LoadMoreImages(loadMoreImagesModel);
    return result;
  }
}
