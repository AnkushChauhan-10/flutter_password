import 'package:equatable/equatable.dart';

abstract class ShowAccountsListEvent extends Equatable {
  const ShowAccountsListEvent();
}

class OnGetShowAccountsListEvent extends ShowAccountsListEvent {
  const OnGetShowAccountsListEvent();

  @override
  List<Object?> get props => [];
}
