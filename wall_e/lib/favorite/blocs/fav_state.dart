import 'package:equatable/equatable.dart';

abstract class FavState extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitialState extends FavState {}

class LoadFailedState extends FavState {
  final String errorMessage;

  LoadFailedState({required this.errorMessage});
}

class LoadDoneState extends FavState {
  final List images;

  LoadDoneState({required this.images});
}

class DownloadImageDone extends FavState {}

class DownloadImageFailed extends FavState {
  final String errorMessage;

  DownloadImageFailed({required this.errorMessage});
}

class RemovedFromFavorite extends FavState {}
