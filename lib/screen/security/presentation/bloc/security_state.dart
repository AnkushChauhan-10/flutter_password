import 'package:equatable/equatable.dart';

class SecurityState extends Equatable {
  const SecurityState({required this.pin, required this.isSetPin});

  const SecurityState.initState() : this(pin: "", isSetPin: false);

  final String pin;
  final bool isSetPin;

  SecurityState copyWith({String? pin, bool? isSetPin}) => SecurityState(
        pin: pin ?? this.pin,
        isSetPin: isSetPin ?? this.isSetPin,
      );

  @override
  List<Object?> get props => [pin, isSetPin];
}
