class TopRatedMovie {
  TopRatedMovie({
    required this.results,
  });

  List<Result>? results;

  factory TopRatedMovie.fromJson(Map<String, dynamic> json) => TopRatedMovie(
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );
}

class Result {
  Result({
    required this.backdropPath,
    required this.posterPath,
  });

  String? backdropPath;

  String? posterPath;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        backdropPath:
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${json['backdrop_path']} ',
        posterPath:
            'https://image.tmdb.org/t/p/w600_and_h900_bestv2${json['poster_path']}',
      );
}
