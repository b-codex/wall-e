import 'package:flutter/cupertino.dart';
import 'package:wall_e/home_page/models/home_page_models.dart';

abstract class HomePageEvent {}

class ImageClickedEvent extends HomePageEvent {
  final imageUrl;
  ImageClickedEvent({required this.imageUrl});
}

class LoadMoreImages extends HomePageEvent {
  final LoadMoreImagesModel loadMoreImagesModel;
  LoadMoreImages({required this.loadMoreImagesModel});
}
