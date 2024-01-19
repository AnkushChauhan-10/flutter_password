import 'package:password/core/utiles/cryptography.dart';
import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/update_account/domain/entities/update_account.dart';

class UpdateAccountModel extends UpdateAccount {
  const UpdateAccountModel({
    required super.title,
    required super.websiteURL,
    required super.email,
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.isUpdate,
  });

  DataMap toMap() => {
        'title': title,
        'email': email,
        'website_url': websiteURL,
        'user_name': userName,
        'password': encodePassword(password),
        'last_update': lastUpdate,
        'is_update': isUpdate ? 1 : 0,
      };
}
