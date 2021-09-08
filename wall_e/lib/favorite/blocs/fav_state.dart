abstract class FavState {}

class IdleState extends FavState {}

class LoadFailed extends FavState {
  final String errorMessage;

  LoadFailed({required this.errorMessage});
}

class LoadDone extends FavState {
  final List images;

  LoadDone({required this.images});
}

class DownloadImageDone extends FavState {}

class DownloadImageFailed extends FavState {
  final String errorMessage;
  
  DownloadImageFailed({required this.errorMessage});
}

class RemovedFromFavorite extends FavState {}
