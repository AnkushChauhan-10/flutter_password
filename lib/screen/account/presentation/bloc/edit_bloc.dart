import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/screen/account/domain/use_case/save_data.dart';
import 'package:password/screen/account/presentation/bloc/edit_event.dart';
import 'package:password/screen/account/presentation/bloc/edit_state.dart';

class EditBloc extends Bloc<EditEvent, EditState> {
  EditBloc({required EditData editData})
      : _editData = editData,
        super(const EditState.initState()) {
    on<OnEdit>(_onEdit);
    on<OnChangeUserName>(_onChangeUserName);
    on<OnChangePassword>(_onChangePassword);
  }

  final EditData _editData;

  Future<void> _onEdit(OnEdit event, Emitter<EditState> emit) async {
    if (validation(event.userName, event.password)) {
      emit(state.copyWith(onSave: false));
      final params = EditDataParam(
        title: event.title,
        userId: event.userName,
        password: event.password,
        lastUpdate: DateTime.now().microsecondsSinceEpoch.toDouble(),
      );
      final result = await _editData(params);
      if (result is SuccessResponse) {
        event.onDone.call();
      } else if (result is FailureResponse) {
        print(result.data);
      }
    }
  }

  Future<void> _onChangeUserName(OnChangeUserName event, Emitter<EditState> emit) async {
    emit(state.copyWith(userName: event.userName));
  }

  Future<void> _onChangePassword(OnChangePassword event, Emitter<EditState> emit) async {
    emit(state.copyWith(password: event.password));
  }

  bool validation(
    String userId,
    String password,
  ) {
    if (validatePassword(password) != null) return false;
    if (validateName(userId) != null) return false;
    return true;
  }

  Future<void> copy(String text) async => await Clipboard.setData(ClipboardData(text: text));
}
