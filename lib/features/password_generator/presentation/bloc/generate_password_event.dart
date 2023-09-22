import 'package:equatable/equatable.dart';

abstract class GeneratePasswordEvent extends Equatable {
  const GeneratePasswordEvent();
}

class OnChangeLength extends GeneratePasswordEvent {
  const OnChangeLength({required this.length, required this.onDone});

  final Function onDone;
  final int length;

  @override
  List<Object?> get props => [length];
}

class OnChangeUpperCase extends GeneratePasswordEvent {
  const OnChangeUpperCase({required this.upperCase, required this.onDone});

  final Function onDone;
  final bool upperCase;

  @override
  List<Object?> get props => [upperCase];
}

class OnChangeLowerCase extends GeneratePasswordEvent {
  const OnChangeLowerCase({required this.lowerCase, required this.onDone});

  final Function onDone;
  final bool lowerCase;

  @override
  List<Object?> get props => [lowerCase];
}

class OnChangeDigit extends GeneratePasswordEvent {
  const OnChangeDigit({required this.digit, required this.onDone});

  final Function onDone;
  final bool digit;

  @override
  List<Object?> get props => [digit];
}

class OnChangeSymbols extends GeneratePasswordEvent {
  const OnChangeSymbols({required this.symbols, required this.onDone});

  final Function onDone;
  final bool symbols;

  @override
  List<Object?> get props => [symbols];
}
