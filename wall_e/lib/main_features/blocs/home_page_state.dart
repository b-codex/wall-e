import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadingState extends HomePageState {}

class LoadDone extends HomePageState {
  final List images;
  LoadDone({required this.images});
}

class LoadFailed extends HomePageState {
  final String errorMessage;
  LoadFailed({required this.errorMessage});
}

class LoadMoreImagesDone extends HomePageState {
  final List images;
  LoadMoreImagesDone({required this.images});
}

class IdleState extends HomePageState {}

class DownloadImageDoneState extends HomePageState {}

class DownloadingImageState extends HomePageState {}

class DownloadImageFailedState extends HomePageState {}
