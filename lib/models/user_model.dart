class UserModel {
  final bool claimed;
  final String id;
  final String name;
  final int points;
  final int dayStreak;

  UserModel({
    required this.claimed,
    required this.id,
    required this.name,
    required this.points,
    required this.dayStreak,
  });

  factory UserModel.fromMap(Map<String, dynamic> data, String id) {
    return UserModel(
      claimed: data['claimed'],
      id: id,
      name: data['name'] ?? '',
      points: data['points'] ?? 0,
      dayStreak: data['day_streak'] ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'points': points, 'day_streak': dayStreak};
  }
}
