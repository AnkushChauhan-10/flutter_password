import 'package:password/core/utiles/typedef.dart';

class UsersModel {
  const UsersModel({
    required this.email,
    required this.name,
    required this.phone,
  });

  final String email;
  final String name;
  final String phone;

  List<String> toListString() => [email, name, phone];

  factory UsersModel.fromListString(List<String> list) => UsersModel(
        email: list[0],
        name: list[1],
        phone: list[2],
      );

  factory UsersModel.fromMap(DataMap map) => UsersModel(
    name: map["name"],
    email: map["email"],
    phone: map["phone"],
  );

  DataMap toMap() => {
    'name': name,
    'email': email,
    'phone': phone,
    'last_update': DateTime.now().microsecondsSinceEpoch
  };

  @override
  List<Object?> get props => [email, phone];
}
