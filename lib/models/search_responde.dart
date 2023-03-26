// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

import 'package:movies/models/models.dart';

class SearchResponse {
    SearchResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    int page;
    List<Movie> results; //Con F2 puedo cambiar el nombre de una variables en toda la clase o donde sea llamada
    int totalPages;
    int totalResults;

    factory SearchResponse.fromRawJson(String str) => SearchResponse.fromJson(json.decode(str));


    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromJson(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
