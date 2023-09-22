import 'package:password/core/utiles/typedef.dart';
import 'package:password/screen/save_data/data/model/account_model.dart';

class UpdateDataModel extends AccountModel {
  const UpdateDataModel({
    required super.userName,
    required super.password,
    required super.lastUpdate,
    required super.isUpdate,
    required super.title,
    required super.websiteURL,
    required super.email,
  });

  const UpdateDataModel.empty() : super.empty();

  factory UpdateDataModel.fromMap(DataMap map) => UpdateDataModel(
        title: map["title"],
        email: map["email"],
        websiteURL: map["website_url"],
        userName: map["user_name"],
        password: map["password"],
        lastUpdate: map["last_update"],
        isUpdate: map['is_update'] == 1 ? true : false,
      );

  @override
  DataMap toMap() => super.toMap();

  @override
  UpdateDataModel copyWith({
    String? title,
    String? email,
    String? websiteURL,
    String? userName,
    String? password,
    String? lastUpdate,
    bool? isUpdate,
  }) =>
      UpdateDataModel(
        title: title ?? this.title,
        websiteURL: websiteURL ?? this.websiteURL,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        isUpdate: isUpdate ?? this.isUpdate,
      );
}
