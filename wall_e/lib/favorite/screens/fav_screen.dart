import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';
import 'package:wall_e/routes/routes.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Favorites"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            print('back clicked');
            final newBloc = BlocProvider.of<FavBloc>(context);
            newBloc.add(IdleEvent());

            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back),
        ),
      ),
      body: BlocBuilder<FavBloc, FavState>(
        builder: (context, state) {
          print(state);

          final bloc = BlocProvider.of<FavBloc>(context);
          bloc.add(LoadFavoriteImagesEvent());
          // if (state is InitialState) {
          // }

          if (state is LoadFailedState) {
            final String errorMessage = state.errorMessage;
            return Center(
              child: Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 20,
                  // color: Colors.red,
                ),
              ),
            );
          }

          if (state is LoadDoneState) {
            List files = state.images;

            print('files from fav screen ========= $files');

            if (files.length == 0) {
              return Center(
                child: Text("No Favorites Yet..."),
              );
            } else {
              return SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: GridView.count(
                          shrinkWrap: true,
                          physics: BouncingScrollPhysics(),
                          crossAxisCount: 2,
                          childAspectRatio: 0.6,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          children: files.map<Widget>(
                            (file) {
                              return GridTile(
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                      RouteManager.favZoomedImage,
                                      arguments: {'imageURL': file},
                                    );
                                  },
                                  child: Hero(
                                    tag: file,
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          file,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
