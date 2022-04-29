import 'package:flutter/material.dart';

class MovieSearchDelegate extends SearchDelegate {

  @override
  String get searchFielLabel => 'Buscar pelicula';

  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      Text('Hola search delegate action')
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return Text('Hola search delegate leading');
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    return Text('Hola search delegate result');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: implement buildSuggestions
    return Text('Hola search delegate leading');
  }

  
  
}