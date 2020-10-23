import 'package:flutter/material.dart';

class FullScreen extends StatelessWidget {
  final String imageUrl;

  FullScreen(
    {
      @required this.imageUrl
    }
  );

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
          body: GridTile(
            child: Hero(
              tag: imageUrl,
              child: Image.network(imageUrl),
            ),
            header: Material(color: Colors.yellow,
              child: FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                padding: EdgeInsets.symmetric(vertical: 15),
                color: Colors.black26,
                child: Text("Back", style: TextStyle(color: Colors.black)),
              ),
            ),
          ),
        ),
    );
  }
}
