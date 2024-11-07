class Category {
  static String musicId = 'music';
  static String sportId = 'sports';
  static String movieId = 'movie';
  String id;
  late String image;
  late String title;
  Category(this.title, this.image, this.id);
  Category.fromId(this.id) {
    image = 'assets/images/$id.png';
    title = id;
  }
  static List<Category> getCategories() {
    return [
      Category.fromId(sportId),
      Category.fromId(movieId),
      Category.fromId(musicId),
    ];
  }
}
