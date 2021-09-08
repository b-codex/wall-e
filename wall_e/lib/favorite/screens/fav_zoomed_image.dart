import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';
import 'package:wall_e/sharedPreference.dart';

class FavZoomedImageScreen extends StatelessWidget {
  final String imageURL;
  const FavZoomedImageScreen({Key? key, required this.imageURL})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    late String _username;
    final _prefs = sharedPreference();

    _prefs.getUsername().then((value) {
      _username = value;
    });

    return BlocConsumer<FavBloc, FavState>(
      listener: (context, state) {
        if (state is DownloadImageDone) {
          final snackBar = SnackBar(
            content: Text(
              'Image Downloaded',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 1,
            ),
            backgroundColor: Colors.green,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
        if (state is DownloadImageFailed) {
          final snackBar = SnackBar(
            content: Text(
              'Download Failed',
              textAlign: TextAlign.center,
            ),
            duration: Duration(
              seconds: 1,
            ),
            backgroundColor: Colors.red,
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<FavBloc>(context);

        return Scaffold(
          body: Stack(
            children: [
              Hero(
                tag: imageURL,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    imageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // Download Button
                    GestureDetector(
                      onTap: () {
                        bloc.add(
                          DownloadImageEvent(imageUrl: imageURL),
                        );
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 8),
                        width: MediaQuery.of(context).size.width / 2,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54, width: 1),
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                            colors: [
                              Color(0x36FFFFFF),
                              Color(0x0FFFFFFF),
                            ],
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Download',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                            Text(
                              'Image Will Be Saved To Gallery',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.white70,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Favorite Button
                    BlocConsumer<FavBloc, FavState>(
                      listener: (context, state) {
                        final snackBar = SnackBar(
                          content: Text('Removed From Favorites',
                              textAlign: TextAlign.center),
                          duration: Duration(
                            seconds: 1,
                          ),
                          backgroundColor: Colors.green,
                        );
                        if (state is RemovedFromFavorite) {
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                          Navigator.of(context).pop();
                        }
                      },
                      builder: (context, state) {
                        return GestureDetector(
                          onTap: () {
                            final fav_bloc = BlocProvider.of<FavBloc>(context);
                            fav_bloc.add(
                              RemoveFromFavoritesEvent(
                                username: _username,
                                imageURL: imageURL,
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 48),
                            width: MediaQuery.of(context).size.width / 2,
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 8),
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.white54, width: 1),
                              borderRadius: BorderRadius.circular(30),
                              gradient: LinearGradient(
                                colors: [
                                  Color(0x36FFFFFF),
                                  Color(0x0FFFFFFF),
                                ],
                              ),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Remove From Favorites',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
