import 'package:equatable/equatable.dart';

abstract class ShowAccountsListEvent extends Equatable {
  const ShowAccountsListEvent();
}

class OnGetShowAccountsListEvent extends ShowAccountsListEvent {
  const OnGetShowAccountsListEvent();

  @override
  List<Object?> get props => [];
}

class OnSearchListEvent extends ShowAccountsListEvent {
  const OnSearchListEvent(this.text);

  final String text;

  @override
  List<Object?> get props => [];
}
