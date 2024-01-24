import 'package:equatable/equatable.dart';

class EditState extends Equatable {
  const EditState({
    required this.title,
    required this.password,
    required this.userName,
    required this.onSave,
  });

  const EditState.initState():this(
    title: "",
    userName: "",
    password: "",
    onSave: false,
  );

  final String password;
  final String title;
  final String userName;
  final bool onSave;

  EditState copyWith({
    String? title,
    String? userName,
    String? password,
    bool? onSave,
  }) =>
      EditState(
        title: title ?? this.title,
        userName: userName ?? this.userName,
        password: password ?? this.password,
        onSave: onSave ?? this.onSave,
      );

  @override
  List<Object?> get props => [title];
}
