import 'package:wall_e/main_features/models/home_page_models.dart';

abstract class HomePageEvent {}

class LoadingEvent extends HomePageEvent {}

class ImageClickedEvent extends HomePageEvent {
  final imageUrl;
  ImageClickedEvent({required this.imageUrl});
}

class LoadMoreImages extends HomePageEvent {
  final LoadMoreImagesModel loadMoreImagesModel;
  LoadMoreImages({required this.loadMoreImagesModel});
}

class DownloadImageEvent extends HomePageEvent {
  final String imageUrl;

  DownloadImageEvent({required this.imageUrl});
}
