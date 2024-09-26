
class User {
  final int userId;
  final String name;
  final String email;
  final String password;
  final String role;
  final String? bio;

  User({
    required this.userId,
    required this.name,
    required this.email,
    required this.password,
    required this.role,
    this.bio,
});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      bio: json['address'],
      role: json['role'] = 'Member'
    );
  }
  Map<String, dynamic> toJson() => {
    'userId': userId,
    'name': name,
    'email': email,
    'password': password,
    'bio': bio,
    'role' : role
  };
}
