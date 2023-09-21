import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/home/domain/entities/account_data.dart';

class AccountDataModel extends AccountData {
  const AccountDataModel({
    required super.siteName,
    required super.id,
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.isUpdate,
  });

  const AccountDataModel.empty()
      : this(
          siteName: "",
          id: "",
          userName: "",
          password: "",
          lastUpdate: "",
          isUpdate: false,
        );

  factory AccountDataModel.fromMap(DataMap map) => AccountDataModel(
        siteName: map["site_name"],
        id: map["id"],
        userName: map["user_name"],
        password: map["password"],
        lastUpdate: DateTime.fromMicrosecondsSinceEpoch(int.parse(map["last_update"])).toString(),
        isUpdate: map['is_update'] == 1 ? true : false,
      );

  DataMap toMap() => {
        'site_name': siteName,
        'id': id,
        'user_name': userName,
        'password': password,
        'last_update': lastUpdate,
        'is_update': isUpdate,
      };

  AccountDataModel copyWith({
    String? siteName,
    String? id,
    String? userName,
    String? password,
    String? lastUpdate,
    bool? isUpdate,
  }) =>
      AccountDataModel(
        siteName: siteName ?? this.siteName,
        id: id ?? this.id,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
