class Constants {
  Constants._();
  static const String baseUrl2 =
      "https://www.omdbapi.com/?i=tt3896198&apikey=e5639d0b";
  static const apiKey2 = "e5639d0b";

  //////////
  static const apiKey = "86adb317601a330d430adead4e089dbf";
  static const baseUrl = "https://api.themoviedb.org/3/";
  static const trendingMoviesURL =
      "https://api.themoviedb.org/3/trending/movie/day?api_key=$apiKey";

  static const topRatedMoviesURL =
      "https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey";
  static const upComingMoviesURL =
      "https://api.themoviedb.org/3/movie/upcoming?api_key=$apiKey";
  static const searchMoviesBaseURL =
      "https://api.themoviedb.org/3/search/movie?api_key=$apiKey";

  static const imagePath = "https://image.tmdb.org/t/p/w500";
}
