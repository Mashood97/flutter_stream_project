class Photo {
  final String title;
  final String url;

  Photo.fromJsonMap(Map map)
      : title = map['title'],
        url = map['url'];
}