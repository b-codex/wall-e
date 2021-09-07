abstract class FavoriteEvent {}

class AddToFavoritesEvent extends FavoriteEvent {
  final String username;
  final String imageURL;

  AddToFavoritesEvent({required this.username, required this.imageURL});
}
