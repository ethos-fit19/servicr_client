class User {
  String image;
  String name;
  String email;
  String phone;
  String city;
  String other;

  // Constructor
  User({
    required this.image,
    required this.name,
    required this.email,
    required this.phone,
    required this.city,
    required this.other,
  });

  User copy({
    String? imagePath,
    String? name,
    String? phone,
    String? email,
    String? where,
    String? other,
  }) =>
      User(
        image: imagePath ?? this.image,
        name: name ?? this.name,
        email: email ?? this.email,
        phone: phone ?? this.phone,
        city: where ?? this.city,
        other: other ?? this.other,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        image: json['imagePath'],
        name: json['name'],
        email: json['email'],
        city: json['where'],
        phone: json['phone'],
        other: json['other'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': image,
        'name': name,
        'email': email,
        'where': city,
        'phone': phone,
        'other': other,
      };
}
