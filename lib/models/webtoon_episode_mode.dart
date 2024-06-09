class WebtoonEpisodeMode {
  final String id, title, rating, date;

  WebtoonEpisodeMode.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        rating = json['rating'],
        date = json['date'];
}
