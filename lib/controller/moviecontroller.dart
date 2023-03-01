import 'dart:convert';
import 'package:get/get.dart';
import 'package:movie_app/Api.dart';
import 'package:movie_app/model/nowPlayingMovie_model.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/topratedmovie.dart';

class MovieController extends GetxController {
  var isLoading = false.obs;

// creating models instance 
  MovieModel? movieModel;
  TopRatedMovie? topRatedMovie;

  @override
  Future<void> onInit() async {
    super.onInit();
    fetchNowPlayingMovies();
     fetchTopRatedMovies();
  }
// featching now playing movies 
  fetchNowPlayingMovies() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.parse(Api.NowPlayingMovies));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        movieModel = MovieModel.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }

// top mvoes fetching from the endpoing 
  fetchTopRatedMovies() async {
    try {
      isLoading(true);
      http.Response response = await http.get(Uri.parse(Api.topRatedMovies));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        topRatedMovie =TopRatedMovie.fromJson(result);
      } else {
        print('error fetching data');
      }
    } catch (e) {
      print('Error while getting data is $e');
    } finally {
      isLoading(false);
    }
  }
}
