import 'dart:math';

import 'package:equatable/equatable.dart';

enum Case { upperCase, lowerCase, digits, symbols}

class GeneratePasswordState extends Equatable {
  const GeneratePasswordState({
    required this.passwordLength,
    required this.upperCase,
    required this.symbols,
    required this.lowerCase,
    required this.digits,
    required this.password,
  });

  const GeneratePasswordState.initState()
      : this(
          passwordLength: 6,
          upperCase: false,
          lowerCase: true,
          digits: false,
          symbols: false,
          password: "",
        );

  final int passwordLength;

  final bool upperCase, lowerCase, digits, symbols;

  final String password;

  GeneratePasswordState copyWith({
    int? passwordLength,
    bool? upperCase,
    bool? lowerCase,
    bool? digits,
    bool? symbols,
    String? password,
  }) =>
      GeneratePasswordState(
        passwordLength: passwordLength ?? this.passwordLength,
        upperCase: upperCase ?? this.upperCase,
        symbols: symbols ?? this.symbols,
        lowerCase: lowerCase ?? this.lowerCase,
        digits: digits ?? this.digits,
        password: password ?? this.password,
      );

  String generatePassword() {
    String password = "";
    for (int i = 0; i < passwordLength; i++) {
      password += _randomCharacter();
    }
    return password;
  }

  String _randomCharacter() {
    String ch = "";
    List<Case> list = [];
    if(upperCase) list.add(Case.upperCase);
    if(lowerCase) list.add(Case.lowerCase);
    if(digits) list.add(Case.digits);
    if(symbols) list.add(Case.symbols);
    if(list.isEmpty) return "";
    switch (list[Random().nextInt(list.length).toInt()]) {
      case Case.upperCase:
        return String.fromCharCode(_randomNumber(65, 91));
      case Case.lowerCase:
        return String.fromCharCode(_randomNumber(97, 123));
      case Case.digits:
        return String.fromCharCode(_randomNumber(48, 58));
      case Case.symbols:
        switch (Random().nextInt(4)) {
          case 0:
            return String.fromCharCode(_randomNumber(33, 48));
          case 1:
            return String.fromCharCode(_randomNumber(91, 97));
          case 2:
            return String.fromCharCode(_randomNumber(123, 127));
          case 3:
            return String.fromCharCode(_randomNumber(58, 65));
        }
    }
    return ch;
  }

  int _randomNumber(int min, int max) => (min + Random().nextInt(max - min));

  @override
  List<Object?> get props => [password, passwordLength, digits, upperCase, lowerCase, symbols];
}
