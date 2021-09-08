import 'package:wall_e/main_features/data_provider/data_provider.dart';
import 'package:wall_e/main_features/models/home_page_models.dart';

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

  Future DownloadImage(String imageURL) async {
    var result =
        await homePageProvider.DownloadImage(imageURL) as Map<dynamic, dynamic>;

    if (result['isSuccess']) {
      return "Success";
    } else {
      return "Failure";
    }
  }
}
