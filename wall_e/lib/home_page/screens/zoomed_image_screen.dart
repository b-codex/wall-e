import 'dart:math';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:wall_e/home_page/blocs/blocs.dart';

class ZoomedImageScreen extends StatelessWidget {
  final String imageURL;
  const ZoomedImageScreen({Key? key, required this.imageURL}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomePageBloc, HomePageState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<HomePageBloc>(context);
        if (state is IdleState) {
          // bloc.add(LoadZoomedImage(zoomedImageModel: ZoomedImageModel(imageUrl: state.)));
        }

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
                    Container(
                      margin: EdgeInsets.only(bottom: 8),
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                          GestureDetector(
                            onTap: () async {
                              bloc.add(DownloadImageEvent(imageUrl: imageURL));

                              if (state is DownloadImageDone) {
                                final snackBar = SnackBar(
                                  content: Text('Image Downloaded',
                                      textAlign: TextAlign.center),
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  backgroundColor: Colors.green,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Download Failed',
                                      textAlign: TextAlign.center),
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Download',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
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
                    Container(
                      margin: EdgeInsets.only(bottom: 48),
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                          GestureDetector(
                            onTap: () async {
                              final snackBar = SnackBar(
                                content: Text('Added To Favorites',
                                    textAlign: TextAlign.center),
                                duration: Duration(
                                  seconds: 1,
                                ),
                                backgroundColor: Colors.green,
                              );
                              var response = await Dio().post(
                                  'http://10.0.2.2:6969/addFavorite?username=&url=$imageURL');
                              if (response.data['status'] == '') {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              } else {
                                final snackBar = SnackBar(
                                  content: Text('Failed To Add To Favorites',
                                      textAlign: TextAlign.center),
                                  duration: Duration(
                                    seconds: 1,
                                  ),
                                  backgroundColor: Colors.red,
                                );
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(snackBar);
                              }
                            },
                            child: Text(
                              'Add To Favorites',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ],
                      ),
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
