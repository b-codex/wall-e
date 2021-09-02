import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wall_e/home_page/blocs/blocs.dart';
import 'package:wall_e/routes/routes.dart';

class HomePageScreen extends StatelessWidget {
  const HomePageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
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
                      'icon/appIcon.ico',
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
                Navigator.of(context).pushNamed(RouteManager.loginPage);
              },
            ),
            ListTile(
              leading: Icon(Icons.star),
              title: Text('Favorites'),
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).pushNamed(
                  RouteManager.forgotPassword,
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
                  onTap: () {},
                ),
              ],
            ),
          ],
        ),
      ),
      body: BlocBuilder<HomePageBloc, HomePageState>(
        builder: (context, state) {
          print(state);

          _buildImages([]);

          if (state is LoadProgress) {
            return LinearProgressIndicator();
          }

          if (state is LoadDone) {
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
                        physics: ClampingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 0.6,
                        mainAxisSpacing: 4.0,
                        crossAxisSpacing: 4.0,
                        children: files.map<Widget>(
                          (file) {
                            return GridTile(
                              child: GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed(
                                  //     RouteManager.image,
                                  //     arguments: {
                                  //       'url': 'http://10.0.2.2:6969/' + file
                                  //     });
                                },
                                child: Hero(
                                  tag: 'http://10.0.2.2:6969/' + file,
                                  child: Container(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        'http://10.0.2.2:6969/' + file,
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
          // return _buildImages(files);
          return Text('data');
        },
      ),
    );
  }
}

Widget _buildImages(List files) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GridView.count(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              crossAxisCount: 2,
              childAspectRatio: 0.6,
              mainAxisSpacing: 4.0,
              crossAxisSpacing: 4.0,
              children: files.map<Widget>(
                (file) {
                  return GridTile(
                    child: GestureDetector(
                      onTap: () {
                        // Navigator.of(context).pushNamed(
                        //     RouteManager.image,
                        //     arguments: {
                        //       'url': 'http://10.0.2.2:6969/' + file
                        //     });
                      },
                      child: Hero(
                        tag: 'http://10.0.2.2:6969/' + file,
                        child: Container(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'http://10.0.2.2:6969/' + file,
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
