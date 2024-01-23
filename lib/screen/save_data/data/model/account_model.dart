import 'package:password/core/utiles/cryptography.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/save_data/domain/entities/account.dart';

class AccountModel extends Account {
  const AccountModel({
    required super.userId,
    required super.password,
    required super.lastUpdate,
    required super.title,
  });

  const AccountModel.empty()
      : this(
          title: "",
          userId: "",
          password: "",
          lastUpdate: 0,
        );

  DataMap toMap() => {
        'title': title,
        'user_id': userId,
        'password': encodePassword(password),
        'last_update': lastUpdate,
      };

  AccountModel copyWith({
    String? title,
    String? userId,
    String? password,
    num? lastUpdate,
  }) =>
      AccountModel(
        title: title ?? this.title,
        userId: userId?? this.userId,
        password: password ?? this.password,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );
}
