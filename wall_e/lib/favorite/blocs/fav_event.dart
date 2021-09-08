abstract class FavEvent {}

class LoadingFavoriteImagesEvent extends FavEvent {}

class DownloadImageEvent extends FavEvent {
  final String imageUrl;

  DownloadImageEvent({required this.imageUrl});
}

class RemoveFromFavoritesEvent extends FavEvent {
  final String username;
  final String imageURL;

  RemoveFromFavoritesEvent({required this.username, required this.imageURL});
}
