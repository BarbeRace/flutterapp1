import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'globals.dart' as globals;

class PageTwo extends StatefulWidget {
  @override
  _PageTwoState createState() => _PageTwoState();
}

Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/1');
  if (response.statusCode == 200) {
    globals.sampleText = Album.fromJson(json.decode(response.body)).title;
    print(Album.fromJson(json.decode(response.body)).title);
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

Future<Album> fetchAlbumBis() async {
  final response =
      await http.get('https://jsonplaceholder.typicode.com/albums/3');
  if (response.statusCode == 200) {
    globals.sampleText = Album.fromJson(json.decode(response.body)).title;
    print(Album.fromJson(json.decode(response.body)).title);
    return Album.fromJson(json.decode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Album {
  final int userId;
  final int id;
  final String title;
  Album({this.userId, this.id, this.title});
  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
    );
  }
}

class FavoriteWidget extends StatefulWidget {
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}

class _FavoriteWidgetState extends State<FavoriteWidget> {
  bool _isFavorited = false;
  int _favoriteCount = 0;
  Future<Album> futureAlbum;

  void _toggleFavorite() {
    setState(() {
      if (_isFavorited) {
        _favoriteCount -= 1;
        _isFavorited = false;
        futureAlbum = fetchAlbumBis();
      } else {
        _favoriteCount += 1;
        _isFavorited = true;
        futureAlbum = fetchAlbum();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            padding: EdgeInsets.all(0),
            alignment: Alignment.centerRight,
            icon: (_isFavorited ? Icon(Icons.star) : Icon(Icons.star_border)),
            color: Colors.red[500],
            onPressed: _toggleFavorite,
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('$_favoriteCount'),
          ),
        ),
      ],
    );
  }
}

class _PageTwoState extends State<PageTwo> {
  Widget titleSection = Container(
    padding: const EdgeInsets.all(32),
    child: Row(
      children: [
        Expanded(
          /*1*/
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /*2*/
              Container(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Le chien chouuuu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                'Un beau husky',
                style: TextStyle(
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
        FavoriteWidget()
      ],
    ),
  );

  Widget textSection = Container(
    padding: const EdgeInsets.all(32),
    child: Text(
      'The Siberian Husky is a medium-sized working dog breed. The breed '
      'belongs to the Spitz genetic family. It is recognizable by its '
      'thickly furred double coat, erect triangular ears, and distinctive '
      'markings, and is smaller than a very similar-looking dog, the '
      'Alaskan Malamute.',
      softWrap: true,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PageTwo"),
      ),
      body:
          ListView(scrollDirection: Axis.vertical, shrinkWrap: true, children: [
        Image.asset(
          'images/husky.jpg',
          width: 600,
          height: 240,
          fit: BoxFit.cover,
        ),
        titleSection,
        textSection,
        Text(globals.sampleText),
        // Bouton retour
        Center(
            child: Column(children: [
          RaisedButton(
              child: Text('Retour'),
              color: Theme.of(context).primaryColor,
              textColor: Colors.white,
              onPressed: () => Navigator.pop(context)),
        ])),
      ]),
    );
  }
}
