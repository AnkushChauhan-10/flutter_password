import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/response/response.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/screen/update_account/domain/use_case/update.dart';
import 'package:password/screen/update_account/presentation/bloc/update_event.dart';
import 'package:password/screen/update_account/presentation/bloc/update_state.dart';

class UpdateBloc extends Bloc<UpdateEvent, UpdateState> {
  UpdateBloc({required Update update})
      : _update = update,
        super(const UpdateState.initState()) {
    on<OnUpdate>(_onUpdate);
    on<Set>(_set);
  }

  final Update _update;

  Future<void> _onUpdate(OnUpdate event, Emitter<UpdateState> emit) async {
    if (validation(event.title, event.userName, event.email, event.password)) {
      emit(state.copyWith(onSave: false));
      final params = UpdateParams(
        title: event.title,
        websiteURL: event.websiteURL,
        userName: event.userName,
        email: event.email,
        password: event.password,
      );
      final result = await _update(params);
      if (result is SuccessResponse) {
        event.onDone.call();
        print("====================================Done=========================================");
      } else if (result is FailureResponse) {
        print(result.data);
      }
    }
  }

  Future<void> _set(Set event, Emitter<UpdateState> emit) async {
    emit(
      state.copyWith(
        title: event.title,
        websiteURL: event.websiteURL,
        userName: event.userName,
        email: event.email,
        password: event.password,
      ),
    );
  }

  bool validation(
    String siteName,
    String userName,
    String userId,
    String password,
  ) {
    if (validateName(siteName) != null) return false;
    if (validatePassword(password) != null) return false;
    if (validateEmail(userId) != null) return false;
    if (validateName(userName) != null) return false;
    return true;
  }
}
