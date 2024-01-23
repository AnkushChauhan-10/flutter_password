import 'package:password/core/utiles/cryptography.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountModel extends ShowAccount {
  const ShowAccountModel({
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.title,
  });

  const ShowAccountModel.empty()
      : this(
          title: "",
          userName: "",
          password: "",
          lastUpdate: "",
        );

  factory ShowAccountModel.fromMap(DataMap map) => ShowAccountModel(
        title: map["title"],
        userName: map["user_id"],
        password: decodePassword(map["password"]),
        lastUpdate: DateTime.fromMicrosecondsSinceEpoch(double.tryParse(map["last_update"].toString())?.toInt() ?? 0).toString(),
      );

  DataMap toMap() => {
        'title': title,
        'user_id': userName,
        'password': password,
        'last_update': lastUpdate,
      };

  ShowAccountModel copyWith({
    String? title,
    String? userName,
    String? password,
    String? lastUpdate,
  }) =>
      ShowAccountModel(
        title: title ?? this.title,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        lastUpdate: lastUpdate ?? this.lastUpdate,
      );
}
