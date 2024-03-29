import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/screen/save_data/domain/use_case/save_data.dart';
import 'package:password/screen/save_data/presentation/bloc/save_event.dart';
import 'package:password/screen/save_data/presentation/bloc/save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  SaveBloc({required SaveData saveData})
      : _saveData = saveData,
        super(const SaveState.initState()) {
    on<OnSave>(_onSave);
    on<OnChangeUserName>(_onChangeUserName);
    on<OnChangePassword>(_onChangePassword);
    on<OnChangeTitle>(_onChangeTitle);
  }

  final SaveData _saveData;

  Future<void> _onSave(OnSave event, Emitter<SaveState> emit) async {
    if (validation(event.title, event.userName, event.password)) {
      emit(state.copyWith(onSave: false));
      final params = SaveDataParam(
        title: event.title,
        userId: event.userName,
        password: event.password,
        lastUpdate: DateTime.now().microsecondsSinceEpoch.toDouble(),
      );
      final result = await _saveData(params);
      if (result is SuccessResponse) {
        event.onDone.call();
        print("====================================Done=========================================");
      } else if (result is FailureResponse) {
        print(result.data);
      }
    }
  }

  Future<void> _onChangeUserName(OnChangeUserName event, Emitter<SaveState> emit) async {
    emit(state.copyWith(userName: event.userName));
  }

  Future<void> _onChangePassword(OnChangePassword event, Emitter<SaveState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _onChangeTitle(OnChangeTitle event, Emitter<SaveState> emit) async {}

  bool validation(
    String siteName,
    String userId,
    String password,
  ) {
    if (validateName(siteName) != null) return false;
    if (validatePassword(password) != null) return false;
    if (validateName(userId) != null) return false;
    return true;
  }
}
