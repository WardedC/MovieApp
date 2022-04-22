import 'package:flutter/material.dart';
import 'package:movie_app/provider/movies_provider.dart';
import 'package:movie_app/widgets/widgets.dart';
import 'package:provider/provider.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final movesProvider = Provider.of<MovieProvider>(context);
    print(movesProvider.onDisplayMovie);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peliculas en cines'),
        centerTitle: true,
        elevation: 0,
        actions:  const [
          IconButton(
            onPressed: null, 
            icon: Icon(Icons.search, color: Colors.white,))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Main cards
            CardSwiper(movies: movesProvider.onDisplayMovie,),
      
            //Movie Sliders
            MovieSlider(
              popularsMovies: movesProvider.onDisplayPopularMovies, 
              title: 'Populars',
              onNextPage: () => movesProvider.getPopularsMovies(),
              ),
      
          ],
        ),
      )
    );
  }
}