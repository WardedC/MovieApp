import 'package:flutter/material.dart';
import 'package:movie_app/models/models.dart';
import 'package:movie_app/provider/movies_provider.dart';
import 'package:provider/provider.dart';

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
      return _isEntyContainer();
    }

    print('Peticion HTTP');

    final moviesProvider = Provider.of<MovieProvider>(context, listen: false);
    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (_, AsyncSnapshot<List<Movie>> snapshot){
        if( !snapshot.hasData ) return _isEntyContainer();
        final movies = snapshot.data;
        return ListView.builder(
          itemCount: movies!.length,
          itemBuilder: (_, int index){
            return _MovieItem(movie: movies[index]);
          }

        );
      }
    ); 
  }

  Widget _isEntyContainer(){
    return Container(
        child: const Center(
          child: Icon(Icons.movie_creation_outlined, color: Colors.redAccent, size: 100,),
        ),
      );
  }
  
  
}

  class _MovieItem extends StatelessWidget {
    final Movie movie;

    const _MovieItem({Key? key, required this.movie}) : super(key: key);
    
  
    @override
    Widget build(BuildContext context) {
      return Hero(
        tag: movie.id,
        child: ListTile(
          leading: FadeInImage(
            placeholder: AssetImage('assets/loading.gif'),
            image: NetworkImage(movie.fullPosterImg),
            width: 50,
            fit: BoxFit.contain,
          ),
          title: Text(movie.title),
          subtitle: Text(movie.originalTitle),
          onTap: (){
            Navigator.pushNamed(context, "Details", arguments: movie );
          },
        ),
      );
    }
  }