import 'package:password/core/utiles/typedef.dart';

class UsersModel {
  const UsersModel({
    required this.email,
    required this.name,
    required this.token,
  });

  const UsersModel.empty() :this(email: " ", name: " ", token: " ");

  final String email;
  final String name;
  final String token;

  List<String> toListString() =>
      [
        email,
        name,
      ];

  factory UsersModel.fromListString(List<String> list) =>
      UsersModel(
        email: list[0],
        name: list[1],
        token: list[2],
      );

  factory UsersModel.fromMap(DataMap map) => UsersModel(name: map["name"], email: map["email"], token: map['token']);

  DataMap toMap() => {'name': name, 'email': email, 'token': token};

  @override
  List<Object?> get props => [email, token];
}
