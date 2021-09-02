abstract class HomePageState {}

class LoadImages extends HomePageState {
  final List images;
  LoadImages({required this.images});
}

class LoadProgress extends HomePageState {}

class LoadDone extends HomePageState {
  final List images;
  LoadDone({required this.images});
}
