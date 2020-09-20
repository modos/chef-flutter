import 'package:flutter/material.dart';

class details extends StatelessWidget {

  String title;
  String description;
  NetworkImage image;

  details({Key key, @required this.title, @required this.description, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 400,
            child: FittedBox(
              child: Image(
                image: image,
              ),
              fit: BoxFit.fill,
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              child: Text(description, textDirection: TextDirection.rtl, style: TextStyle(fontSize: 24),),
            ),
          )
        ],
      ),
    );
  }
}
