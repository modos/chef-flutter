
import 'package:chef/form.dart';
import 'package:chef/formController.dart';
import 'package:flutter/material.dart';
import 'package:loading_animations/loading_animations.dart';
import 'data.dart';
import 'details.dart';

class view extends StatefulWidget {

  view({Key key}) : super(key : key);

  @override
  _viewState createState() => _viewState();
}

class _viewState extends State<view> {

  //var cards = data.getData;
  bool _isSearching = false;
  var search_icon = Icons.search;
  Widget appBar_title = Text("Chef Recipes");
  TextEditingController _searchQuery = new TextEditingController();
  String _searchText = "";

  bool _isCompleted;

  List<form> cards = List<form>();
  List<form> items = List<form>();

  _viewState() {
    _isCompleted = false;
    _searchQuery.addListener(() {
      if (_searchQuery.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
          items = cards;
        });
      }
      else {
        setState(() {
          _isSearching = true;
          _searchText = _searchQuery.text;
          items = cards.where((element) => element.title.contains(_searchText)).toList();
        });
      }
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();

    formController().getFeedbackList().then((cards) {
      setState(() {
        this.cards = cards;
        this.items = this.cards;
        items.length = items.length - 1;
      });
    });

    formController().getFeedbackList().whenComplete(() {
      setState(() {
        _isCompleted = true;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp (
      theme: ThemeData.dark(),
      title: "Chef Recipes",
      home: Scaffold (
          appBar: AppBar (
            title: appBar_title,
            actions: <Widget>[
              Padding(
                padding: EdgeInsets.only(right: 10),
                child:  IconButton(
                  icon: Icon(
                    search_icon,
                    size: 40,
                  ),
                  onPressed: () {
                    setState(() {
                      if (search_icon == Icons.search) {
                        search_icon = Icons.close;
                        _isSearching = true;
                        appBar_title = TextField(
                          controller: _searchQuery,
                          style: TextStyle(
                              color: Colors.white
                          ),
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            hintText: "...جستجو",
                          ),
                        );


                      }else {
                        search_icon = Icons.search;
                        appBar_title = Text("Chef Recipes");
                        _isSearching = false;
                        _searchQuery.clear();
                      }
                    });
                  },
                ),
              )

            ],
          ),
          body:    _isCompleted == false ? Center(
            child: LoadingBouncingGrid.circle(
                size: 90,
              backgroundColor: Colors.amber,
            ),
          ) : Container(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                      itemCount: items.length,
                      itemBuilder: (context, index ) {
                        return Container (
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            height: 220,
                            width: double.maxFinite,
                            child: InkWell(
                              child: Card (
                                  elevation: 5,
                                  child: Row (
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: <Widget>[
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(24.0),
                                          child: Column (
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            textDirection: TextDirection.rtl,
                                            children: <Widget>[
                                              Text(
                                                items[index].title,
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              Text(
                                                items[index].description,
                                                style: TextStyle(
                                                  fontSize: 18,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 3,
                                                textAlign: TextAlign.right,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(right: 20),
                                        width: 150,
                                        height: 150,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(items[index].image)
                                            )
                                        ),
                                      ),

                                    ],
                                  )
                              ),
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => details(title: items[index].title, description: items[index].description, image: NetworkImage(items[index].image)),
                                  ),
                                );
                              },
                            ),
                        );
                      }),
                )
              ],
            ),
          )
      ),
    );
  }
}

