class AnimeEntity {
  String dates;
  String startDate;
  String endDate;
  bool airing;
  String background;
  String broadcast;
  String duration;
  List<String> endingThemes;
  int episodes;
  int favorites;
  List<String> genres;
  String imageUrl;
  int id;
  int members;
  List<String> openingThemes;
  int popularity;
  String premiered;
  int rank;
  String rating;
  double score;
  int scoredBy;
  String status;
  String synopsis;
  String title;
  String titleEnglish;
  String titleJapanese;
  String trailerUrl;
  String type;
  bool isFavorite;

  AnimeEntity({
    this.dates = '',
    this.startDate = '',
    this.endDate = '',
    this.airing = false,
    this.background = '',
    this.broadcast = '',
    this.duration = '',
    this.endingThemes = const [],
    this.episodes = 0,
    this.favorites = 0,
    this.genres = const [],
    this.imageUrl = '',
    this.id = 0,
    this.members = 0,
    this.openingThemes = const [],
    this.popularity = 0,
    this.premiered = '',
    this.rank = 0,
    this.rating = '',
    this.score = 0,
    this.scoredBy = 0,
    this.status = '',
    this.synopsis = '',
    this.title = '',
    this.titleEnglish = '',
    this.titleJapanese = '',
    this.trailerUrl = '',
    this.type = '',
    this.isFavorite = false,
  });
}
