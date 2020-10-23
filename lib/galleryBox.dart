import 'package:flutter/material.dart';
import 'fullScreen.dart';

class GalleryBox extends StatelessWidget {
  final String title;
  final String author;
  final String url;
  final String urlFull;

  GalleryBox(
    {
      @required this.title,
      @required this.author,
      @required this.url,
      @required this.urlFull,
    }
  );

  @override 
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Navigator.push(context, 
          MaterialPageRoute(builder: (context) => FullScreen(imageUrl: urlFull,)));
        },
      child: Hero(
        tag: url,
        child: Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(30)),
          child: GridTile(
            footer: Material(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              borderRadius: BorderRadius.circular(5),
              child: GridTileBar(
                backgroundColor: Colors.black45,
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10), 
                  child: Text(
                    title, 
                    style: TextStyle(
                      fontWeight: FontWeight.w700, 
                      color: Colors.yellow
                    ),
                  ),
                ),
                subtitle: Text(author),
              ),
            ),
            child: Image.network(url,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center
            ), 
          ),
        ),
      ),
    );
  }
}
