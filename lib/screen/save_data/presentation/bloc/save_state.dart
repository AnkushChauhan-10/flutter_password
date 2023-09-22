import 'package:equatable/equatable.dart';

class SaveState extends Equatable {
  const SaveState({
    required this.title,
    required this.password,
    required this.userName,
    required this.email,
    required this.websiteURL,
    required this.onSave,
  });

  const SaveState.initState():this(
    title: "",
    websiteURL: "",
    email: "",
    userName: "",
    password: "",
    onSave: false,
  );

  final String email;
  final String websiteURL;
  final String password;
  final String title;
  final String userName;
  final bool onSave;

  SaveState copyWith({
    String? title,
    String? email,
    String? websiteURL,
    String? userName,
    String? password,
    bool? onSave,
  }) =>
      SaveState(
        title: title ?? this.title,
        websiteURL: websiteURL ?? this.websiteURL,
        email: email ?? this.email,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        onSave: onSave ?? this.onSave,
      );

  @override
  List<Object?> get props => [title];
}
