
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/models.dart';



class MoviesProvider extends ChangeNotifier {

  final String _apiKey   = '4a55a865548dd4a8c44aa4b26e85aa18';
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  int _popularPage = 0;   //para trabajar con el infinity scroll del movie_slieder


  MoviesProvider() {
    print('MoviesProvider inicializado');

    getOnDisplayMovies();

    getPopularMovies();
  }

  // Optimizando el código para poder llamarlo en los métodos y llamar los datos json ya mapeados en los modelos
  Future<String> _getJsonData(endpoint, [page = 1]) async {
    var url = Uri.https( _baseUrl, endpoint, {
      'api_key' : _apiKey,
      'language': _language,
      'page'    : '$page',
    });

  // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('/3/movie/now_playing');
     
    final nowPlayingResponse = NowPlayingResponse.fromRawJson(jsonData);
    
    print(nowPlayingResponse.results[1].originalTitle);
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await _getJsonData('/3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromRawJson(jsonData);
    
    popularMovies = [...popularMovies, ...popularResponse.results ];

    notifyListeners();
  }
}