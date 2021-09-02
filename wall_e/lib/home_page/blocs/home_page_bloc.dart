import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/home_page/blocs/blocs.dart';
import 'package:wall_e/home_page/repository/home_page_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageRepository homePageRepository;

  HomePageBloc({required this.homePageRepository})
      : super(LoadImages(images: ['1','2']));

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LoadImages) {
      // Load Images Here
      yield LoadProgress();
      print('object');
      await Future.delayed(Duration(seconds: 2));
      final response = await homePageRepository.LoadImages();
      yield LoadDone(images: response);
    }

    if (event is LoadMoreImages) {
      yield LoadProgress();

      await Future.delayed(Duration(seconds: 3));
      final response =
          await homePageRepository.LoadMoreImages(event.loadMoreImagesModel);
      yield LoadDone(images: response);
    }
  }
}
