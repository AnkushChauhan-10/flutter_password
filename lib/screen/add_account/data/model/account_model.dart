import 'package:password/core/utiles/typedef.dart';
import 'package:password/features/save_data/domain/entities/account.dart';

class AccountModel extends Account {
  const AccountModel({
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.isUpdate,
    required super.title,
    required super.websiteURL,
    required super.email,
  });

  const AccountModel.empty()
      : this(
          title: "",
          websiteURL: "",
          email: "",
          userName: "",
          password: "",
          lastUpdate: "",
          isUpdate: false,
        );

  DataMap toMap() => {
        'title': title,
        'email': email,
        'website_url': websiteURL,
        'user_name': userName,
        'password': password,
        'last_update': lastUpdate,
        'is_update': isUpdate ? 1 : 0,
      };

  AccountModel copyWith({
    String? title,
    String? email,
    String? websiteURL,
    String? userName,
    String? password,
    String? lastUpdate,
    bool? isUpdate,
  }) =>
      AccountModel(
        title: title ?? this.title,
        websiteURL: websiteURL ?? this.websiteURL,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
