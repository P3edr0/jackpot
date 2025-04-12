class JackpotEntity {
  JackpotEntity({
    required this.id,
    required this.banner,
    required this.potValue,
    required this.title,
    required this.isFavorite,
  });
  String banner;
  int id;
  String potValue;
  String title;
  bool isFavorite;
}
