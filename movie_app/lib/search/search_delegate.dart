import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFieldLabel => 'Search Movie';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      IconButton(
        onPressed: (){
          query = '';
        }, 
        icon: Icon(Icons.clear)
        )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      onPressed: (){
        close(context, null);
      }, 
      icon: Icon(Icons.arrow_back_ios_new)
    );

  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('Hola search delegate result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {

    if(query.isEmpty){
      return Container(
        child: Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.redAccent, size: 100,),
        ),
      );
    }

    return Container();
  }

  
  
}