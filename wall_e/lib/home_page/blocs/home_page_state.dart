abstract class HomePageState {}

class LoadingState extends HomePageState {}

class LoadDone extends HomePageState {
  final List images;
  LoadDone({required this.images});
}

class LoadMoreImagesDone extends HomePageState {
  final List images;
  LoadMoreImagesDone({required this.images});
}

class IdleState extends HomePageState {}
