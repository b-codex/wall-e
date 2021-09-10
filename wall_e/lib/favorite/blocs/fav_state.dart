import 'package:equatable/equatable.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';

abstract class FavState extends Equatable {}

class IdleState extends FavState {
  @override
  List<Object?> get props => [];
}

class LoadFailed extends FavState {
  final String errorMessage;

  LoadFailed({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class LoadDone extends FavState {
  final List images;

  LoadDone({required this.images});

  @override
  List<Object?> get props => [];
}

class DownloadImageDone extends FavState {
  @override
  List<Object?> get props => [DownloadImageDone()];
}

class DownloadImageFailed extends FavState {
  final String errorMessage;

  DownloadImageFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}

class RemovedFromFavorite extends FavState {
  @override
  List<Object?> get props => [];
}
