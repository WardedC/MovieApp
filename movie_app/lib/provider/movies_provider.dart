import 'package:flutter/cupertino.dart';

class MovieProvider extends ChangeNotifier{

  MovieProvider(){
    print('MoviesProvider initialization');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies(){
    print('onDisplayMovie');
  }
  
}