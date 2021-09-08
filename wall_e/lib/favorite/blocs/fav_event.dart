abstract class FavEvent {}

class LoadingFavoriteImagesEvent extends FavEvent {}

class DownloadImage extends FavEvent {
  final String imageUrl;

  DownloadImage({required this.imageUrl});
}

class RemoveFromFavoritesEvent extends FavEvent {
  final String username;
  final String imageURL;

  RemoveFromFavoritesEvent({required this.username, required this.imageURL});
}
