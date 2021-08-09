import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wall_e/sharedPreference.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class ImageAction extends StatefulWidget {
  // ImageAction({Key? key}) : super(key: key);
  late final String url;
  ImageAction({required this.url});

  @override
  _ImageActionState createState() => _ImageActionState();
}

class _ImageActionState extends State<ImageAction> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);

    var _prefs = sharedPreference();
    late var username;
    _prefs.getUsername().then((value) => {username = value});

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      // ),
      body: Stack(
        children: [
          Hero(
            tag: widget.url,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Image.network(
                widget.url,
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
                          final snackBar = SnackBar(
                            content: Text('Image Downloaded',
                                textAlign: TextAlign.center),
                            duration: Duration(
                              seconds: 1,
                            ),
                            backgroundColor: Colors.green,
                          );
                          var response = await Dio().get(widget.url,
                              options:
                                  Options(responseType: ResponseType.bytes));
                          final result = await ImageGallerySaver.saveImage(
                              Uint8List.fromList(response.data));
                          print(result);
                          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text(
                          'Download',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                      // Text(
                      //   'Image Will Be Saved To Gallery',
                      //   style: TextStyle(
                      //     fontSize: 10,
                      //     color: Colors.white70,
                      //   ),
                      // ),
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
                              'http://10.0.2.2:6969/addFavorite?username=$username&url=${widget.url}');
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
  }
}

// _saveImage(String url) async {
//   // var res = await .get(url);

//   new Directory('/storage/emulated/0/Wall-e/').create();
//   File file = new File('/storage/emulated/0/Wall-e/');
//   // file.writeAsBytesSync(bytes);
// }
