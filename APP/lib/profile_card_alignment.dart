import 'package:flutter/material.dart';
import 'friend.dart';
import 'package:http/http.dart' as http;

class ProfileCardAlignment extends StatelessWidget {
  final int cardNum;
  Friend _friends;

  Friend get friends => _friends;

  set friends(Friend friends) {
    print(friends.avatar);
    _friends = friends;
  }

  ProfileCardAlignment(this.cardNum) {
    _loadFriends()
      ..then((friends)=>{
        this.friends = friends
      });
  }

  Future<Friend> _loadFriends() async {
    final http.Response response = await http.get('https://randomuser.me/api/?results=1');

    //print(response.body);
    return  Friend.allFromResponse(response.body)[0];
  }

  @override
  Widget build(BuildContext context) {
    if (_friends == null) {
      return Card();
    }
    return Card(
      child: Stack(
        children: <Widget>[
          SizedBox.expand(
            child: Material(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(_friends.avatar, fit: BoxFit.cover),
            ),
          ),
          SizedBox.expand(
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.transparent, Colors.black54],
                      begin: Alignment.center,
                      end: Alignment.bottomCenter)),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(_friends.name,
                        style: TextStyle(
                            color: Colors.cyanAccent,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w700)),
                    Padding(padding: EdgeInsets.only(bottom: 8.0)),
                    Text(_friends.location,
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.white)),
                  ],
                )),
          )
        ],
      ),
    );
  }
}
