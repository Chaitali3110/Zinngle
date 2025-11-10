class Creator {
  final String id;
  final String name;
  final String avatar;
  final String category;
  final double rating;
  final int pricePerMin;
  final bool isOnline;
  final int totalCalls;
  final String bio;

  Creator({
    required this.id,
    required this.name,
    required this.avatar,
    required this.category,
    required this.rating,
    required this.pricePerMin,
    required this.isOnline,
    required this.totalCalls,
    required this.bio,
  });
}