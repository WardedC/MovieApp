import 'package:flutter/cupertino.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:movie_app/models/models.dart';

class MovieProvider extends ChangeNotifier{

  String _apiKey = '400329993463a8f208ce3403a8cb071f';
  String _baseUrl = 'api.themoviedb.org';
  String _lenguage = 'es-ES';

  MovieProvider(){
    print('MoviesProvider initialization');
    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async{
    var url = Uri.https(this._baseUrl, '3/movie/now_playing', 
      {'api_key': this._apiKey,
      'language': this._lenguage,
      'page': '1'}
    );
    final response = await http.get(url);
    
    final nowPlayingResponse = NowPlayingResponse.fromJson(response.body);
    //final decodeData = convert.jsonDecode(response.body) as Map<String, dynamic>;
    print(nowPlayingResponse.results[0].title);
  }
  
}