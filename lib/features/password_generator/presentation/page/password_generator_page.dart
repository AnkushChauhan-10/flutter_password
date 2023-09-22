import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_bloc.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_event.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_state.dart';

class PasswordGeneratorPage extends StatelessWidget {
  const PasswordGeneratorPage({super.key, Function(String)? generatePassword}) : _generatePassword = generatePassword;

  final Function(String)? _generatePassword;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(builder: (context, state) {
      int passwordLength = state.passwordLength;
      bool upperCase = state.upperCase;
      bool lowerCase = state.lowerCase;
      bool digits = state.digits;
      bool symbols = state.symbols;
      return Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Flexible(
              child: Text(
                "Generate Password",
                style: TextStyle(),
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    flex: 2,
                    child: Text(
                      "Length",
                      style: TextStyle(),
                    ),
                  ),
                  Flexible(
                    flex: 5,
                    child: Slider(
                      label: "length",
                      value: passwordLength.toDouble(),
                      onChanged: (value) {
                        context.read<GeneratePasswordBloc>().add(OnChangeLength(
                            length: value.toInt(),
                            onDone: (password) {
                              _generatePassword?.call(password);
                            }));
                      },
                      min: 6,
                      max: 20,
                    ),
                  ),
                  Flexible(
                    child: Text(
                      passwordLength.toString(),
                      style: TextStyle(),
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      "Use Upper Case Letters (A-Z)",
                      style: TextStyle(),
                    ),
                  ),
                  Flexible(
                    child: Switch(
                      splashRadius: 10,
                      value: upperCase,
                      onChanged: (value) {
                        context.read<GeneratePasswordBloc>().add(OnChangeUpperCase(
                            upperCase: value,
                            onDone: (password) {
                              _generatePassword?.call(password);
                            }));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      "Use Lower Case Letters (a-z)",
                      style: TextStyle(),
                    ),
                  ),
                  Flexible(
                    child: Switch(
                      value: lowerCase,
                      onChanged: (value) {
                        context.read<GeneratePasswordBloc>().add(OnChangeLowerCase(
                            lowerCase: value,
                            onDone: (password) {
                              _generatePassword?.call(password);
                            }));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      "Use Digits (0-9)",
                      style: TextStyle(),
                    ),
                  ),
                  Flexible(
                    child: Switch(
                      value: digits,
                      onChanged: (value) {
                        context.read<GeneratePasswordBloc>().add(OnChangeDigit(
                            digit: value,
                            onDone: (password) {
                              _generatePassword?.call(password);
                            }));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Flexible(
                    child: Text(
                      "Use Symbols",
                      style: TextStyle(),
                    ),
                  ),
                  Flexible(
                    child: Switch(
                      value: symbols,
                      onChanged: (value) {
                        context.read<GeneratePasswordBloc>().add(OnChangeSymbols(
                            symbols: value,
                            onDone: (password) {
                              _generatePassword?.call(password);
                            }));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }
}
