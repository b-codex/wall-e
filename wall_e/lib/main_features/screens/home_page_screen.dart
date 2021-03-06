import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/auth/login/blocs/blocs.dart';
import 'package:wall_e/auth/login/screens/login_screen.dart';
import 'package:wall_e/favorite/blocs/blocs.dart';

import 'package:wall_e/main_features/blocs/blocs.dart';
import 'package:wall_e/main_features/models/home_page_models.dart';
import 'package:wall_e/routes/routes.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int nextStart = 1;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text('Wall-e'),
        centerTitle: true,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    minRadius: 50,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      'assets/images/appIcon.png',
                      width: 100,
                    ),
                  ),
                  Text(
                    'Wall-e',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.account_circle),
              title: Text('Profile'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(RouteManager.profilePage);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites'),
              onTap: () {
                final newBloc = BlocProvider.of<FavBloc>(context);
                newBloc.add(IdleEvent());
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  RouteManager.favoritesPage,
                );
              },
            ),
            Expanded(
              child: Container(),
            ),
            Column(
              children: [
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text('Logout'),
                  onTap: () {
                    final logout = BlocProvider.of<HomePageBloc>(context);
                    final checkLoginStatus =
                        BlocProvider.of<LoginBloc>(context);
                    logout.add(LogoutUser());
                    checkLoginStatus.add(CheckLoginStatus());
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<HomePageBloc>(context);

          if (state is IdleState) {
            bloc.add(LoadingEvent());
          }

          if (state is LoadFailed) {
            final String errorMessage = state.errorMessage;
            return Center(
              child: Text(
                errorMessage,
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.red,
                ),
              ),
            );
          }

          if (state is LoadDone) {
            List files = state.images;
            nextStart = files.length;

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
                                    RouteManager.zoomedImage,
                                    arguments: {
                                      'imageURL': 'http://10.0.2.2:69/' + file
                                    },
                                  );
                                },
                                child: Hero(
                                  tag: 'http://10.0.2.2:69/' + file,
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://10.0.2.2:69/' + file,
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
                    SizedBox(height: 25),
                    OutlinedButton(
                      onPressed: () {
                        bloc.add(
                          LoadMoreImages(
                            loadMoreImagesModel: LoadMoreImagesModel(
                              start: nextStart + 1,
                              end: nextStart + 20,
                            ),
                          ),
                        );
                        nextStart = nextStart + 20;
                      },
                      child: Text("Load Another Batch"),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is LoadMoreImagesDone) {
            List files = state.images;

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
                                    RouteManager.zoomedImage,
                                    arguments: {
                                      'imageURL': 'http://10.0.2.2:69/' + file
                                    },
                                  );
                                },
                                child: Hero(
                                  tag: 'http://10.0.2.2:69/' + file,
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://10.0.2.2:69/' + file,
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
                    SizedBox(height: 25),
                    OutlinedButton(
                      onPressed: () {
                        bloc.add(
                          LoadMoreImages(
                            loadMoreImagesModel: LoadMoreImagesModel(
                              start: nextStart + 1,
                              end: nextStart + 20,
                            ),
                          ),
                        );
                        nextStart = nextStart + 20;
                      },
                      child: Text("Load Another Batch"),
                    ),
                  ],
                ),
              ),
            );
          }

          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
