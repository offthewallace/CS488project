import 'package:flutter/material.dart';
import 'package:tinder_cards/MyHomePage.dart';
import 'package:tinder_cards/ProfilePage.dart';
import 'package:tinder_cards/chat.dart';
import 'cards_section_alignment.dart';
import 'cards_section_draggable.dart';
import 'test.dart';
import 'package:flutter_tindercard/flutter_tindercard.dart';
import 'friendList.dart';

class SwipeFeedPage extends StatefulWidget {
  @override
  _SwipeFeedPageState createState() => _SwipeFeedPageState();
}

class _SwipeFeedPageState extends State<SwipeFeedPage> {
  bool showAlignmentCards = false;
  CardsSectionAlignment tempcard;

  @override
  Widget build(BuildContext context) {
    User userprofile = ModalRoute.of(context).settings.arguments;
    print(userprofile.username);

    final cards = CardsSectionAlignment(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfilePage(),
                      settings: RouteSettings(
                        arguments: userprofile,
                      )));
            },
            icon: Icon(Icons.settings, color: Colors.grey)),
        title: Switch(
          onChanged: (bool value) => setState(() => showAlignmentCards = value),
          value: showAlignmentCards,
          activeColor: Colors.red,
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FriendsListPage(),
                        settings: RouteSettings(
                          arguments: userprofile,
                        )));
              },
              icon: Icon(Icons.question_answer, color: Colors.grey)),
        ],
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[tempcard = cards, buttonsRow(cards)],
      ),
    );
  }

  Widget buttonsRow(CardsSectionAlignment cards) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 48.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          FloatingActionButton(
            heroTag: 'refresh',
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.loop, color: Colors.yellow),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: 'exit',
            //TODO: set up the like or dislike or may be how to trigger with the
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.close, color: Colors.red),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: 'like',
            onPressed: () {
              if (cards.state != null) {
                print(cards.state.frontCardAlign.x);
                cards.state.animateCards();
              }
            },
            backgroundColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.green),
          ),
          Padding(padding: EdgeInsets.only(right: 8.0)),
          FloatingActionButton(
            heroTag: 'star',
            mini: true,
            onPressed: () {},
            backgroundColor: Colors.white,
            child: Icon(Icons.star, color: Colors.blue),
          ),
        ],
      ),
    );
  }
}
