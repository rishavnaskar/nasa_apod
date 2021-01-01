import 'dart:io';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dsc_project/API/api.dart';
import 'package:dsc_project/FUNCTIONS/GoogleLogin.dart';
import 'package:dsc_project/SCREENS/Details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dsc_project/FUNCTIONS/Components.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:photofilters/photofilters.dart';
import 'package:image/image.dart' as imageLib;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Widget> mainWidgets = [];
  ScrollController _scrollController = ScrollController();
  int tagNumber = 0;

  @override
  Widget build(BuildContext context) {
    mainWidgets.addAll({
      Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              icon: Icon(Icons.exit_to_app),
              color: Colors.white,
              onPressed: () => GoogleLogin().googleLogoutUser(context))),
      SizedBox(height: MediaQuery
          .of(context)
          .size
          .height * 0.05),
      Title(),
      MainWidget(tagNumber: ++tagNumber),
    });
    return Scaffold(
      backgroundColor: Color(0xff1E1E1E),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/wallpaper2.jpg'))),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: ListView(
                      controller: _scrollController, children: mainWidgets),
                ),
                SizedBox(height: MediaQuery
                    .of(context)
                    .size
                    .height * 0.05)
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent)
        mainWidgets.add(MainWidget(tagNumber: ++tagNumber));
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

class MainWidget extends StatefulWidget {
  MainWidget({this.tagNumber});

  final int tagNumber;

  @override
  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  var thumbUrl, hdUrl, copyRight, explanation, date, title;
  File imageFile;
  var image;
  String fileName;
  EdgeInsetsGeometry _buttonPadding = EdgeInsets.symmetric(
      vertical: 15, horizontal: 50);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery
            .of(context)
            .size
            .height * 0.1),
        Stack(
          children: [
            Center(
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.15),
                    Container(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * 0.8,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * 0.65,
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.transparent.withOpacity(0.2),
                                  spreadRadius: 5,
                                  blurRadius: 5,
                                  offset: Offset(10, 10))
                            ],
                            borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(
                            vertical: 10, horizontal: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.2),
                            FutureBuilder(
                                future: Api().getApi(),
                                builder: (context, snapshot) {
                                  if (!snapshot.hasData) return Container();

                                  var result = snapshot.data;
                                  title = result['title'];
                                  copyRight = result['copyright'];
                                  explanation = result['explanation'];
                                  hdUrl = result['hdurl'];
                                  date = result['date'].toString();

                                  return Text(title,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: 'Montserrat',
                                          letterSpacing: 2,
                                          fontSize: 20));
                                }),
                            SizedBox(
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .height * 0.06),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RaisedButton(
                                  onPressed: () =>
                                      Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                              pageBuilder: (_, __, ___) =>
                                                  Details(
                                                      title: title,
                                                      copyRight: copyRight,
                                                      date: date,
                                                      explanation: explanation,
                                                      tagNumber: widget
                                                          .tagNumber,
                                                      hdUrl: hdUrl))),
                                  padding: _buttonPadding,
                                  child: Icon(Icons.info),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                SizedBox(width: 30),
                                RaisedButton(
                                  onPressed: () => urlToImageFile(thumbUrl, context),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  padding: _buttonPadding,
                                  child: Icon(Icons.edit),
                                )
                              ],
                            ),
                            SizedBox(height: 20),
                          ],
                        )),
                  ],
                )),
            FutureBuilder(
                future: Api().getApi(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return Components().kCircularProgressIndicator;

                  var result = snapshot.data;
                  thumbUrl = result['url'];

                  return Align(
                    alignment: Alignment.topCenter,
                    child: Hero(
                      tag: '${widget.tagNumber}',
                      child: imageFile == null
                          ? CachedNetworkImage(
                        imageUrl: thumbUrl,
                        errorWidget: (context, url, error) =>
                            Text(error),
                        fadeInCurve: Curves.fastOutSlowIn,
                        fadeInDuration: Duration(milliseconds: 1000),
                        imageBuilder: (context, image) =>
                            Container(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                                image: DecorationImage(
                                    fit: BoxFit.fill, image: image),
                              ),
                            ),
                      )
                          : Image.file(imageFile, fit: BoxFit.cover,
                          frameBuilder: (context, image, __, ___) {
                            return Container(
                              height:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                              width:
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 0.6,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: image),
                            );
                          }),
                    ),
                  );
                }),
          ],
        ),
      ],
    );
  }

  urlToImageFile(String url, BuildContext context) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return Components().kAlertDialog;
        });
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;
    imageFile = File('$tempPath' + '.png');
    http.Response response = await http.get(url);
    await imageFile.writeAsBytes(response.bodyBytes);
    setState(() {
      fileName = basename(imageFile.path);
      image = imageLib.decodeImage(imageFile.readAsBytesSync());
      image = imageLib.copyResize(image, width: 600);
    });
    Map tempImageFile = await Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) =>
                PhotoFilterSelector(
                    title: Text('SPACE EDIT'),
                    filters: presetFiltersList,
                    image: image,
                    filename: fileName)));
    if (tempImageFile != null && tempImageFile.containsKey('image_filtered'))
      setState(() {
        imageFile = tempImageFile['image_filtered'];
      });
    Navigator.pop(context);
  }
}

class Title extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Text('SPACE & BEYOND',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  fontSize: 27)),
        ),
        SizedBox(height: 10),
        Center(
          child: Text('Witness the unimaginable',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.bold,
                  fontSize: 15)),
        )
      ],
    );
  }
}
