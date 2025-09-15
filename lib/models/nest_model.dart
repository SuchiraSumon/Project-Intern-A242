class NestModel {
  final String id;
  final double currentAmount;
  final String image;
  final String name;
  final double targetAmount;

  NestModel({
    required this.id,
    required this.currentAmount,
    required this.image,
    required this.name,
    required this.targetAmount,
  });

  factory NestModel.fromMap(Map<String, dynamic> data, String id) {
    return NestModel(
      id: id,
      currentAmount: (data['current_amount'] ?? 0).toDouble(),
      image: data['image'] ?? '',
      name: data['name'] ?? '',
      targetAmount: (data['target_amount'] ?? 0).toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'current_amount': currentAmount,
      'image': image,
      'name': name,
      'target_amount': targetAmount,
    };
  }
}
