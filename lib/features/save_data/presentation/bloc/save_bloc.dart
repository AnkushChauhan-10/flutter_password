import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/features/save_data/domain/use_case/save_data.dart';
import 'package:password/features/save_data/presentation/bloc/save_event.dart';
import 'package:password/features/save_data/presentation/bloc/save_state.dart';

class SaveBloc extends Bloc<SaveEvent, SaveState> {
  SaveBloc({required SaveData saveData})
      : _saveData = saveData,
        super(const SaveState.initState()) {
    on<OnSave>(_onSave);
    on<OnChangeUserName>(_onChangeUserName);
    on<OnChangePassword>(_onChangePassword);
    on<OnChangeSiteName>(_onChangeSiteName);
    on<OnChangeId>(_onChangeId);
  }

  final SaveData _saveData;

  Future<void> _onSave(OnSave event, Emitter<SaveState> emit) async {
    if(validation(event.siteName, event.userName, event.id, event.password, event.confirmPassword)){
      emit(state.copyWith(onSave: false));
      final params = SaveDataParam(
        siteName: event.siteName,
        userName: event.userName,
        id: event.id,
        password: event.password,
        lastUpdate: DateTime.now().microsecondsSinceEpoch.toString(),
      );
      final result = await _saveData(params);
      if(result is SuccessResponse) {
        event.onDone.call();
        print("====================================Done=========================================");
      }else if(result is FailureResponse){
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

  Future<void> _onChangeSiteName(OnChangeSiteName event, Emitter<SaveState> emit) async {
    emit(state.copyWith(password: event.siteName));
  }

  Future<void> _onChangeId(OnChangeId event, Emitter<SaveState> emit) async {
    emit(state.copyWith(siteName: event.id));
  }

  bool validation(String siteName, String userName, String userId, String password, String confirmPassword,){
    if(validateName(siteName) != null) return false;
    if(validatePassword(password) != null) return false;
    if(validateEmail(userId) != null) return false;
    if(validateConfirmPassword(password, confirmPassword) != null) return false;
    if(validateName(userName) != null ) return false;
    return true;
  }
}
