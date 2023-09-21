import 'package:equatable/equatable.dart';

class AccountData extends Equatable {
  final String siteName;
  final String id;
  final String userName;
  final String password;
  final String lastUpdate;
  final bool isUpdate;

  const AccountData({
    required this.siteName,
    required this.id,
    required this.userName,
    required this.password,
    required this.lastUpdate,
    required this.isUpdate,
  });

  const AccountData.empty()
      : this(
          siteName: "",
          id: "",
          userName: "",
          password: "",
          lastUpdate: "",
          isUpdate: false,
        );

  @override
  List<Object?> get props => [id];
}
