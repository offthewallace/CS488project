import 'package:flutter/material.dart';
import 'swipe_feed_page.dart';

import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

Future<User> createUser(String email, String password) async {
  final http.Response response = await http.post(
    'https://78xsb883zk.execute-api.us-east-1.amazonaws.com/default/login',
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      'username': email,
      'password': password,
    }),
  );

  if (response.statusCode == 200) {
    print(response.body);
    return User.fromJson(json.decode(response.body));
  } else {
    throw Exception('Wrong password/email');
  }
}

class User {
  final String username;
  final String bio;
  final String birth;
  final String city;
  final String country;
  final String gender;
  final String name;
  final String surname;
  final String image;

  User(
      {this.username,
      this.bio,
      this.birth,
      this.city,
      this.country,
      this.gender,
      this.name,
      this.surname,
      this.image});


  @override
  String toString() {
    return 'User{username: $username, bio: $bio, birth: $birth, city: $city, country: $country, gender: $gender, name: $name, surname: $surname, image: $image}';
  }

  factory User.fromJson(Map<String, dynamic> response) {
    var user = json.decode(response['user']);
    return User(
        username: user['username'],
        bio: user['bio'],
        birth: user['birth'],
        city: user['city'],
        country: user['country'],
        gender: user['gender'],
        name: user['name'],
        surname: user['surname'],
        image: user['image']);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final emailField = TextFormField(
      controller: emailController,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Email",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final passwordField = TextFormField(
      controller: passwordController,
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Color(0xff01A0C7),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () {

          createUser(emailController.text, passwordController.text)
            ..then((futureUser) => {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SwipeFeedPage(),
                          settings: RouteSettings(
                            arguments: futureUser,
                          )))
                })
          ..timeout(Duration(seconds: 5));
        },
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
        body: SingleChildScrollView(
      child: Center(
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(36.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 155.0,
                  child: Image.asset(
                    "assets/logo.png",
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 45.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 35.0,
                ),
                loginButton,
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
