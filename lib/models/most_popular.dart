class MostPopular {
  final String image;
  final String description;
  final String category;
  String price;
  String? discount;
  bool favorite;

  MostPopular(
      {required this.image,
      required this.description,
      required this.category,
      required this.price,
      required this.discount,
      required this.favorite});
}
