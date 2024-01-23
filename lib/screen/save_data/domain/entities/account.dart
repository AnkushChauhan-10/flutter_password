import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String title;
  final String userId;
  final String password;
  final num lastUpdate;

  const Account({
    required this.title,
    required this.userId,
    required this.password,
    required this.lastUpdate,
  });

  const Account.empty()
      : this(
          title: "",
          userId: "",
          password: "",
          lastUpdate: 0,
        );

  @override
  List<Object?> get props => [title];
}
