import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_bloc.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_event.dart';
import 'package:password/features/password_generator/presentation/bloc/generate_password_state.dart';

class PasswordGeneratorPage extends StatefulWidget {
  const PasswordGeneratorPage({super.key, this.generatePassword});

  final Function(String)? generatePassword;

  @override
  State<StatefulWidget> createState() => _PasswordGeneratorPage();
}

class _PasswordGeneratorPage extends State<PasswordGeneratorPage> {
  late bool value;

  @override
  void initState() {
    value = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Function(String)? generatePassword = widget.generatePassword;
    return BlocBuilder<GeneratePasswordBloc, GeneratePasswordState>(builder: (context, state) {
      int passwordLength = state.passwordLength;
      bool upperCase = state.upperCase;
      bool lowerCase = state.lowerCase;
      bool digits = state.digits;
      bool symbols = state.symbols;
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Generate Password",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Switch(
                  value: value,
                  onChanged: (v) {
                    value = v;
                    setState(() {});
                  },
                )
              ],
            ),
          ),
          Visibility(
            visible: value,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
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
                      Slider(
                        label: "length",
                        value: passwordLength.toDouble(),
                        onChanged: (value) {
                          context.read<GeneratePasswordBloc>().add(OnChangeLength(
                              length: value.toInt(),
                              onDone: (password) {
                                generatePassword?.call(password);
                              }));
                        },
                        min: 6,
                        max: 20,
                      ),
                      Text(
                        passwordLength.toString(),
                        style: TextStyle(),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Flexible(
                        child: Text(
                          "Use Upper Case Letters (A-Z)",
                          style: TextStyle(),
                        ),
                      ),
                      Switch(
                        splashRadius: 10,
                        value: upperCase,
                        onChanged: (value) {
                          context.read<GeneratePasswordBloc>().add(OnChangeUpperCase(
                              upperCase: value,
                              onDone: (password) {
                                generatePassword?.call(password);
                              }));
                        },
                      ),
                    ],
                  ),
                  Row(
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
                                  generatePassword?.call(password);
                                }));
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
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
                                  generatePassword?.call(password);
                                }));
                          },
                        ),
                      ),
                    ],
                  ),
                  Row(
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
                                  generatePassword?.call(password);
                                }));
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
