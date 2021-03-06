import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'friend.dart';
import 'chat.dart';
import 'package:tinder_cards/MyHomePage.dart';

class FriendsListPage extends StatefulWidget {
  @override
  _FriendsListPageState createState() => new _FriendsListPageState();
}

class _FriendsListPageState extends State<FriendsListPage> {
  List<Friend> _friends = [];

  @override
  void initState() {
    super.initState();
    _loadFriends();
  }
    //'/match/find/?key=' + key
  //https://78xsb883zk.execute-api.us-east-1.amazonaws.com/default/match/find
  Future<void> _loadFriends() async {

    http.Response response =
    await http.get('https://randomuser.me/api/?results=10&nat=us&seed=123@456.com');

    setState(() {
      _friends = Friend.allFromResponse(response.body);
    });
  }

  Widget _buildFriendListTile(BuildContext context, int index) {
    var friend = _friends[index];

    return new ListTile(
      onTap: () => _navigateToFriendDetails(friend, index),
      leading: new Hero(
        tag: index,
        child: new CircleAvatar(
          backgroundImage: new NetworkImage(friend.avatar),
        ),
      ),
      title: new Text(friend.name),
      subtitle: new Text(friend.email),
    );
  }

  void _navigateToFriendDetails(Friend friend, Object avatarTag) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Chat(
              peerId: friend.email,
              peerAvatar: friend.avatar,
              ID:'123@456.com',
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    User userprofile = ModalRoute.of(context).settings.arguments;
    print(userprofile.username);


    if (_friends.isEmpty) {
      content = new Center(
        child: new CircularProgressIndicator(),
      );
    } else {
      content = new ListView.builder(
        itemCount: _friends.length,
        itemBuilder: _buildFriendListTile,
      );
    }

    return new Scaffold(
      appBar: new AppBar(title: new Text('Friends')),
      body: content,
    );
  }
}