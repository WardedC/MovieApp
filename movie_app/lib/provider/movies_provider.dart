import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';


class MovieProvider extends ChangeNotifier{

  String _apiKey = '400329993463a8f208ce3403a8cb071f';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  List<Movie> onDisplayMovie = [];
  List<Movie> onDisplayPopularMovies = [];

  int _populatePage = 0;

  MovieProvider(){
    print('MoviesProvider initialization');
    this.getOnDisplayMovies();
    this.getPopularsMovies();
  }

  Future<String>_getJsonData( String endPoint, [int page = 1] ) async{
    var url = Uri.https(this._baseUrl, endPoint, 
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
  
}