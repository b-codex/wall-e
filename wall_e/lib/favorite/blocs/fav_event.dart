import 'package:equatable/equatable.dart';

abstract class FavEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class IdleEvent extends FavEvent {}

class LoadFavoriteImagesEvent extends FavEvent {}

class DownloadImage extends FavEvent {
  final String imageUrl;

  DownloadImage({required this.imageUrl});
}

class RemoveFromFavoritesEvent extends FavEvent {
  final String username;
  final String imageURL;

  RemoveFromFavoritesEvent({required this.username, required this.imageURL});
}
