class MoviesModal {
  int? page;
  List<Results>? results;
  int? totalPages;
  int? totalResults;

  MoviesModal({this.page, this.results, this.totalPages, this.totalResults});

  MoviesModal.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}

class Results {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;

  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  // for TV shows
  String? name;
  String? firstAirDate;
  List<String>? originCountry;
  String? originalName;

  Results({
    this.adult,
    this.backdropPath,
    this.genreIds,
    this.id,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.releaseDate,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,

    // for TV shows
    this.name,
    this.firstAirDate,
    this.originCountry,
    this.originalName,
  });

  Results.fromJson(Map<String, dynamic> json) {
    adult = json['adult'] ?? false;
    backdropPath = json['backdrop_path'];
    genreIds = json['genre_ids'].cast<int>();
    id = json['id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'] ?? "";
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    releaseDate = json['release_date'] ?? "";
    title = json['title'] ?? "";
    video = json['video'] ?? false;
    voteAverage = json['vote_average'].toDouble();
    voteCount = json['vote_count'];

    // for TV shows
    name = json['name'] ?? "";
    firstAirDate = json['first_air_date'] ?? "";
    originCountry = json['origin_country'] == null
        ? [""].cast<String>()
        : json['origin_country'].cast<String>();
    originalName = json['original_name'] ?? "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;

    // for TV shows
    data['name'] = name;
    data['first_air_date'] = firstAirDate;
    data['origin_country'] = originCountry;
    data['original_name'] = originalName;

    return data;
  }
}
