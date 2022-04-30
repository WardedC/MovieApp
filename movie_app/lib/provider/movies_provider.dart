import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/helpers/debouncer.dart';
import 'package:movie_app/models/models.dart';


class MovieProvider extends ChangeNotifier{

  String _apiKey = '400329993463a8f208ce3403a8cb071f';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  List<Movie> onDisplayMovie = [];
  List<Movie> onDisplayPopularMovies = [];
  Map<int, List<Cast>> moviesCast = {};

  int _populatePage = 0;

  final debouncer = Debouncer(duration: Duration(milliseconds: 500));

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>>  get suggestionStream => this._suggestionStreamController.stream;

  MovieProvider(){
    print('MoviesProvider initialization');
    this.getOnDisplayMovies();
    this.getPopularsMovies();
  }

  Future<String>_getJsonData( String endPoint, [int page = 1] ) async{
    final url = Uri.https(this._baseUrl, endPoint, 
      {'api_key': this._apiKey,
      'language': this._lenguage,
      'page': '$page'}
    );
    final response = await http.get(url);
    return response.body;

  }

  getOnDisplayMovies() async{
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    this.onDisplayMovie = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularsMovies() async{
    this._populatePage++;
    final jsonData = await this._getJsonData('3/movie/popular',_populatePage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    this.onDisplayPopularMovies = [...onDisplayPopularMovies, ... popularResponse.results];
    print(onDisplayPopularMovies[0]);
    notifyListeners();
  }

  Future<List<Cast>> getMoviesCast(int movieId) async{
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    print('Get info - Cast');
    final jsonData = await this._getJsonData('3/movie/$movieId/credits',_populatePage);
    final creditsResponse = CreditsResponse.fromJson(jsonData);
    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async{
    final url = Uri.https(this._baseUrl, '3/search/movie', 
      {'api_key': this._apiKey,
      'language': this._lenguage,
      'query': query
      });
    final response = await http.get(url);
    final searchResponse = SearchResponse.fromJson(response.body);
    return searchResponse.results;
  }

  void getSuggestionByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value)async {
      //print('Tenemos valor: $value');
      final result = await this.searchMovies(value);
      this._suggestionStreamController.add(result);
    };
    final timer = Timer.periodic(Duration(milliseconds: 300) , (_) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());

  }
  
}