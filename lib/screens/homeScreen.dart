import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_gallery/values/colors.dart';
import 'package:my_gallery/values/strings.dart';
import 'package:my_gallery/widget/curved_navigation_bar.dart';
import 'package:my_gallery/widget/dialog/progressDialog.dart';
import 'package:photo_gallery/photo_gallery.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Poppins',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'HomeScreen'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BuildContext bcontext;
  int bottomIndex = 0;
  List<Album> _imageAlbums;
  List<Album> _videoAlbums;
  bool isLoading = true;
  bool isImage = true;
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();

  @override
  Widget build(BuildContext context) {
    bcontext = context;
    return Scaffold(
      backgroundColor: UIColor.white,
      bottomNavigationBar: CurvedNavigationBar(
        initialIndex: 0,
        items: <Widget>[
          Icon(
            Icons.image,
            size: 30,
            color: UIColor.light_blue1,
          ),
          Icon(
            Icons.video_library_rounded,
            size: 30,
            color: UIColor.light_blue1,
          ),
        ],
        color: UIColor.secondPrimaryColor,
        buttonBackgroundColor: UIColor.colorPrimary,
        backgroundColor: Colors.transparent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 600),
        onTap: (index) {
          setState(() {
            bottomIndex = index;
            if (index == 0) {
              isImage = true;
            } else {
              isImage = false;
            }
          });
        },
      ),
      body: new Center(
        child: isLoading
            ? CircularProgressIndicator(
                backgroundColor: UIColor.colorPrimary,
              )
            : LayoutBuilder(
                builder: (context, constraints) {
                  double gridWidth = (constraints.maxWidth - 20) / 2;
                  double gridHeight = gridWidth + 43;
                  double ratio = gridWidth / gridHeight;
                  return Container(
                    margin: EdgeInsets.only(bottom: 25),
                    padding: EdgeInsets.all(5),
                    child: GridView.count(
                      childAspectRatio: ratio,
                      crossAxisCount: 2,
                      children: <Widget>[
                        ...?isImage?_imageAlbums?.map(
                          (album) => GestureDetector(
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  child: Container(
                                    color: UIColor.cardGreyColor,
                                    height: gridWidth,
                                    width: gridWidth,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: album.id,
                                        mediumType: album.mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: gridWidth,
                                  color: UIColor.cardGreyColor,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text(
                                      album.name,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: UIColor.addButton_color,
                                        height: 1.2,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ):_videoAlbums?.map(
                          (album) => GestureDetector(
                            child: Column(
                              children: <Widget>[
                                ClipRRect(
                                  child: Container(
                                    color: UIColor.cardGreyColor,
                                    height: gridWidth,
                                    width: gridWidth,
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder:
                                          MemoryImage(kTransparentImage),
                                      image: AlbumThumbnailProvider(
                                        albumId: album.id,
                                        mediumType: album.mediumType,
                                        highQuality: true,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: gridWidth,
                                  color: UIColor.cardGreyColor,
                                  alignment: Alignment.topLeft,
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text(
                                      album.name,
                                      maxLines: 1,
                                      textAlign: TextAlign.start,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: UIColor.addButton_color,
                                        height: 1.2,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  Future<void> initImageAsync() async {
    List<Album> albums =
        await PhotoGallery.listAlbums(mediumType: MediumType.image);
    setState(() {
      _imageAlbums = albums;
      isLoading = false;
    });
  }

  Future<void> initVideoAsync() async {
    List<Album> albums =
        await PhotoGallery.listAlbums(mediumType: MediumType.video);
    setState(() {
      _videoAlbums = albums;
    });
  }

  @override
  void initState() {
    MediaPage mediaPage;
    initImageAsync();
    initVideoAsync();
  }
}
