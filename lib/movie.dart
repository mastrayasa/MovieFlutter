class MovieHub {
  List<Movie> movie;

  MovieHub({this.movie});

  MovieHub.fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
        movie = new List<Movie>();
        json['results'].forEach((v) {
        movie.add(new Movie.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.movie != null) {
      data['results'] = this.movie.map((v) => v.toJson()).toList();
    }
    return data;
  }


}

class Movie {
  int id;
  String title;
  String poster_path;
  String backdrop_path;
  String overview;

  Movie(
      {
        this.id,
        this.title,
        this.poster_path,
        this.backdrop_path,
        this.overview
      });

  Movie.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    poster_path = json['poster_path'];
    overview = json['overview'];
    backdrop_path = json['backdrop_path'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['poster_path'] = this.poster_path;
    data['backdrop_path'] = this.backdrop_path;
    data['overview'] = this.overview;
    return data;
  }
}

