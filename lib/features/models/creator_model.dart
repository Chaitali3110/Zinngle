class Creator {
  final String id;
  final String name;
  final String avatar;
  final String category;
  final double rating;
  final int totalCalls;
  final double pricePerMin;
  final String bio;
  final bool isOnline;

  const Creator({
    required this.id,
    required this.name,
    required this.avatar,
    required this.category,
    required this.rating,
    required this.totalCalls,
    required this.pricePerMin,
    required this.bio,
    this.isOnline = false,
  });
}