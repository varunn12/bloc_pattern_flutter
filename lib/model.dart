
import 'dart:async';
import 'dart:convert';

import 'package:bloc_project/api_key.dart';
import 'package:http/http.dart' as http;

class Movie{
  final String title, posterPath, overview;
  Movie(this.title, this.posterPath, this.overview);

  Movie.fromJson(Map json)
  :overview=json['overview'],
  posterPath=json['poster_path'],
  title=json['title'];
}

class API {
  final http.Client _client=http.Client();

  static const String _url='https://api.themoviedb.org/3/search/movie?api_key=$APIKEY&query={1}';

  Future<List<Movie>> get(String query) async{
    List<Movie> list=[];
    await _client.get(Uri.parse(_url.replaceFirst("{1}", query)),
    headers: {'Content-Type':'application/x-www-form-urlencoded'})
    .then((res)=>res.body)
    .then(json.decode)
    .then((json)=>json['results'])
    .then((movies)=>movies.forEach((movie)=>list.add(Movie.fromJson(movie))));
    print(list.toString());
    return list;
  }

}