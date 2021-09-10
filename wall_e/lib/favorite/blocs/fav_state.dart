import 'package:equatable/equatable.dart';

abstract class FavState extends Equatable {}

class InitialState extends FavState {
  @override
  List<Object?> get props => [];
}

class LoadFailedState extends FavState {
  final String errorMessage;

  LoadFailedState({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class LoadDoneState extends FavState {
  final List images;

  LoadDoneState({required this.images});

  @override
  List<Object?> get props => [];
}

class DownloadImageDone extends FavState {
  @override
  List<Object?> get props => [];
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
