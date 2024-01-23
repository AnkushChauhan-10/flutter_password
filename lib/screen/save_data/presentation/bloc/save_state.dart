import 'package:equatable/equatable.dart';

class SaveState extends Equatable {
  const SaveState({
    required this.title,
    required this.password,
    required this.userName,
    required this.onSave,
  });

  const SaveState.initState():this(
    title: "",
    userName: "",
    password: "",
    onSave: false,
  );

  final String password;
  final String title;
  final String userName;
  final bool onSave;

  SaveState copyWith({
    String? title,
    String? userName,
    String? password,
    bool? onSave,
  }) =>
      SaveState(
        title: title ?? this.title,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        onSave: onSave ?? this.onSave,
      );

  @override
  List<Object?> get props => [title];
}
