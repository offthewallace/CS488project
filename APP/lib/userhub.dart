import 'package:cached_network_image/cached_network_image.dart';
import 'package:circular_profile_avatar/circular_profile_avatar.dart';
import 'package:flutter/material.dart';
import 'package:tinder_cards/StoryPage/gnews.dart';
import 'package:tinder_cards/videoChat/src/pages/index.dart';
import 'package:tinder_cards/trex/TRexGameWrapper.dart';
import 'package:tinder_cards/2048/home.dart';



class MyUserHub extends StatefulWidget {
  MyUserHub({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyUserHubState createState() => _MyUserHubState();
}

class  _MyUserHubState extends State<MyUserHub> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: SingleChildScrollView(
          child:Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 50,
                  height: 50,

                ),

              // testing for child widget which is using FlutterLogo
              CircularProfileAvatar(
                'https://elasticbeanstalk-us-east-1-861432961105.s3.amazonaws.com/icon2.png',
                //'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWtMDksH9GzFdMinyAkGbtLJNx6xynLETTNN5akjxirL3QD5Rj',
                errorWidget: (context, url, error) => Container(
                  child: Icon(Icons.error),
                ),
                placeHolder: (context, url) => Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
                radius: 90,
                backgroundColor: Colors.transparent,
                borderWidth: 10,
                initialsText: Text(
                  "",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
                borderColor: Colors.blue,
                elevation: 5.0,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(),
                        // settings: RouteSettings(arguments: userprofile,)

                      ));
                },
                cacheImage: true,
                showInitialTextAbovePicture: true,
              ),
                 Container(
                  width: 50,
                  height: 50,

                ),
              CircularProfileAvatar(
                 'https://elasticbeanstalk-us-east-1-861432961105.s3.amazonaws.com/icon.png',
                //'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcRWtMDksH9GzFdMinyAkGbtLJNx6xynLETTNN5akjxirL3QD5Rj',
                errorWidget: (context, url, error) => Container(
                  child: Icon(Icons.error),
                ),
                placeHolder: (context, url) => Container(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(),
                ),
                radius: 90,
                backgroundColor: Colors.transparent,
                borderWidth: 10,
                  initialsText: Text(
                   "",
                   style: TextStyle(fontSize: 40, color: Colors.white),
                  ),
                borderColor: Colors.blue,
                elevation: 5.0,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TRexGameWrapper(),
                        // settings: RouteSettings(arguments: userprofile,)

                      ));
                },
                cacheImage: true,
                showInitialTextAbovePicture: true,
              ),
              ],
          ),
        )));
  }
}