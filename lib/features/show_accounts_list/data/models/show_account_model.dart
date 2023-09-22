import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/show_accounts_list/domain/entities/show_account.dart';

class ShowAccountModel extends ShowAccount {
  const ShowAccountModel({
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.isUpdate,
    required super.title,
    required super.websiteURL,
    required super.email,
  });

  const ShowAccountModel.empty()
      : this(
          title: "",
          websiteURL: "",
          email: "",
          userName: "",
          password: "",
          lastUpdate: "",
          isUpdate: false,
        );

  factory ShowAccountModel.fromMap(DataMap map) => ShowAccountModel(
        title: map["title"],
        email: map["email"],
        websiteURL: map["website_url"],
        userName: map["user_name"],
        password: map["password"],
        lastUpdate: DateTime.fromMicrosecondsSinceEpoch(int.parse(map["last_update"])).toString(),
        isUpdate: map['is_update'] == 1 ? true : false,
      );

  DataMap toMap() => {
        'title': title,
        'email': email,
        'website_url': websiteURL,
        'user_name': userName,
        'password': password,
        'last_update': lastUpdate,
        'is_update': isUpdate,
      };

  ShowAccountModel copyWith({
    String? title,
    String? email,
    String? websiteURL,
    String? userName,
    String? password,
    String? lastUpdate,
    bool? isUpdate,
  }) =>
      ShowAccountModel(
        title: title ?? this.title,
        websiteURL: websiteURL ?? this.websiteURL,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
