import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {}

class LoadingState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class LoadDone extends HomePageState {
  final List images;
  LoadDone({required this.images});

  @override
  List<Object?> get props => [];
}

class LoadFailed extends HomePageState {
  final String errorMessage;
  LoadFailed({required this.errorMessage});

  @override
  List<Object?> get props => [];
}

class LoadMoreImagesDone extends HomePageState {
  final List images;
  LoadMoreImagesDone({required this.images});
  
  @override
  List<Object?> get props => [];
}

class IdleState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class DownloadImageDone extends HomePageState {
  @override
  List<Object?> get props => [];
}

class DownloadingImageState extends HomePageState {
  @override
  List<Object?> get props => [];
}

class DownloadImageFailed extends HomePageState {
  @override
  List<Object?> get props => [];
}
