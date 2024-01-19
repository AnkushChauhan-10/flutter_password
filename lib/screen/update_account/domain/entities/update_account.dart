import 'package:password/screen/save_data/domain/entities/account.dart';

class UpdateAccount extends Account {
  const UpdateAccount({
    required super.title,
    required super.websiteURL,
    required super.email,
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.isUpdate,
  });
}
