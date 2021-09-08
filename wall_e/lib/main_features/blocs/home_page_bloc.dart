import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/main_features/blocs/blocs.dart';
import 'package:wall_e/main_features/repository/home_page_repository.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final HomePageRepository homePageRepository;

  HomePageBloc({required this.homePageRepository}) : super(IdleState());

  @override
  Stream<HomePageState> mapEventToState(HomePageEvent event) async* {
    if (event is LoadingEvent) {
      await Future.delayed(Duration(seconds: 1));
      final response = await homePageRepository.LoadImages();

      if (response.length == 0) {
        yield LoadFailed(errorMessage: 'API Error');
      } else {
        yield LoadDone(images: response);
      }
    }

    if (event is LoadMoreImages) {
      yield LoadingState();

      await Future.delayed(Duration(seconds: 1));
      final response =
          await homePageRepository.LoadMoreImages(event.loadMoreImagesModel);

      yield LoadMoreImagesDone(images: response);
    }

    if (event is DownloadImageEvent) {
      final response = await homePageRepository.DownloadImage(event.imageUrl);

      if (response == 'Success') {
        yield DownloadImageDone();
      }
      if (response == 'Failure') {
        print('failed');
        yield DownloadImageFailed();
      }
    }
  }
}
