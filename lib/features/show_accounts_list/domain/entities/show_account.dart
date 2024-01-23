import 'package:equatable/equatable.dart';

class ShowAccount extends Equatable {
  final String title;
  final String userName;
  final String password;
  final String lastUpdate;

  const ShowAccount({
    required this.title,
    required this.userName,
    required this.password,
    required this.lastUpdate,
  });

  const ShowAccount.empty()
      : this(
          title: "",
          userName: "",
          password: "",
          lastUpdate: "",
        );

  @override
  List<Object?> get props => [title];
}
