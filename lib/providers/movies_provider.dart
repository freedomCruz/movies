
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';



class MoviesProvider extends ChangeNotifier {

  final String _apiKey   = '4a55a865548dd4a8c44aa4b26e85aa18';
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];


  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();

    getPopularMovies();
  }

  getOnDisplayMovies() async {
     var url = Uri.https( _baseUrl, '/3/movie/now_playing', {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '1',
    });

  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(response.body);
    
    print(nowPlayingResponse.results[1].originalTitle);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https( _baseUrl, '/3/movie/popular', {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '1',
    });

  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    final popularResponse = PopularResponse.fromRawJson(response.body);
    
    popularMovies = [...popularMovies, ...popularResponse.results ];

    notifyListeners();
  }
}