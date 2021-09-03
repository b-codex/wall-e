abstract class HomePageState {}

class Loading extends HomePageState{}

class LoadDone extends HomePageState {
  final List images;
  LoadDone({required this.images});
}
