import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String title;
  final String email;
  final String websiteURL;
  final String userName;
  final String password;
  final String lastUpdate;
  final bool isUpdate;

  const Account({
    required this.title,
    required this.websiteURL,
    required this.email,
    required this.userName,
    required this.password,
    required this.lastUpdate,
    required this.isUpdate,
  });

  const Account.empty()
      : this(
          title: "",
          websiteURL: "",
          email: "",
          userName: "",
          password: "",
          lastUpdate: "",
          isUpdate: false,
        );

  @override
  List<Object?> get props => [title];
}
