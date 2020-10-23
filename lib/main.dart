import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_test/galleryBox.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'galleryBox.dart';


Future<Album> fetchAlbum() async {
  final response =
      await http.get('https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0');

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Photo {
  final String author;
  final String id;
  final String title;
  final String url;
  final String urlFull;

  Photo({this.author, this.id, this.title, this.url, this.urlFull});
}

class Album {
  final List<Photo> photos;

  Album({this.photos});

  factory Album.fromJson(List<dynamic> json) {
    List<Photo> photos = json.map((data) => (Photo(
      id: data['id'],
      author: data['user']['name'],
      title: data['alt_description'],
      url: data['urls']['small'],
      urlFull: data['urls']['regular'],
    ))).toList();

    return Album(photos: photos);
  }
}

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Album> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Gallery_Test'),
        ),
        body: FutureBuilder<Album>(
            future: futureAlbum,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                  ),
                  padding: const EdgeInsets.all(20),
                  itemCount: snapshot.data.photos.length,
                  itemBuilder: (context, index) {
                    return GalleryBox(
                      title: snapshot.data.photos[index].title,
                      author: snapshot.data.photos[index].author,
                      url: snapshot.data.photos[index].url,
                      urlFull: snapshot.data.photos[index].urlFull,
                    );
                  },
                ); 
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
        ),
      ),
    );
  }
}
