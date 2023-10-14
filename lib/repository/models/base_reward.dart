class BaseReward {
  String id;
  String name;
  String description;
  int number;
  int price;
  int availability;
  int? count;
  DateTime createdAt;
  DateTime updatedAt;
  BaseReward({
    required this.id,
    required this.name,
    required this.description,
    required this.number,
    required this.price,
    required this.availability,
    this.count,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BaseReward.fromJson(Map<String, dynamic> json) => BaseReward(
        id: json['_id'],
        name: json['name'],
        description: json['description'],
        number: json['number'],
        price: json['price'],
        availability: json['availability'],
        count: json['count'],
        createdAt: DateTime.parse(json['createdAt']),
        updatedAt: DateTime.parse(json['updatedAt']),
      );

  Map<String, dynamic> toJson() => {
        '_id': id,
        'name': name,
        'description': description,
        'number': number,
        'price': price,
        'availability': availability,
        'count': count,
        'createdAt': createdAt.toIso8601String(),
        'updatedAt': updatedAt.toIso8601String(),
      };
}
