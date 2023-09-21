import 'package:equatable/equatable.dart';

class SaveState extends Equatable {
  const SaveState({
    required this.siteName,
    required this.password,
    required this.userName,
    required this.id,
    required this.onSave,
  });

  const SaveState.initState():this(
    siteName: "",
    password: "",
    userName: "",
    id: "",
    onSave: false,
  );

  final String id;
  final String password;
  final String siteName;
  final String userName;
  final bool onSave;

  SaveState copyWith({
    String? siteName,
    String? password,
    String? userName,
    String? id,
    bool? onSave,
  }) =>
      SaveState(
        siteName: siteName ?? this.siteName,
        password: password ?? this.password,
        userName: userName ?? this.userName,
        id: id ?? this.id,
        onSave: onSave ?? this.onSave,
      );

  @override
  List<Object?> get props => [id];
}
