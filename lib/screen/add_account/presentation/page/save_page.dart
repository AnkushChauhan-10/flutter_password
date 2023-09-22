import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/features/password_generator/presentation/page/password_generator_page.dart';
import 'package:password/features/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/features/save_data/presentation/bloc/save_event.dart';
import 'package:password/features/save_data/presentation/bloc/save_state.dart';
import 'package:password/features/save_data/presentation/widgets/save_button.dart';

class SavePage extends StatefulWidget {
  const SavePage({super.key});

  @override
  State<StatefulWidget> createState() => _SavePage();
}

class _SavePage extends State<SavePage> {
  final TextEditingController _title = TextEditingController(),
      _email = TextEditingController(),
      _userName = TextEditingController(),
      _password = TextEditingController(),
      _websiteURL = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add New Account"),
      ),
      body: BlocBuilder<SaveBloc, SaveState>(
        builder: (context, state) {
          return Form(
            key: _key,
            child: Column(
              children: [
                Flexible(
                  child: CommonField(
                    controller: _title,
                    label: "Title",
                    validation: validateName,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _websiteURL,
                    label: 'Website URL',
                    validation: validateName,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _email,
                    label: 'Email',
                    validation: validateEmail,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _userName,
                    label: "User Name",
                    validation: validateName,
                  ),
                ),
                Flexible(
                  child: CommonField(
                    controller: _password,
                    label: "Password",
                    validation: validatePassword,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: PasswordGeneratorPage(
                    generatePassword: (password) {
                      setState(() {
                        _password.text = password;
                      });
                      print("=========================>>>> $password");
                    },
                  ),
                ),
                Flexible(
                  child: SaveButton(
                    onPressed: () {
                      _key.currentState?.validate();
                      context.read<SaveBloc>().add(
                            OnSave(
                              title: _title.text,
                              password: _password.text,
                              userName: _userName.text,
                              email: _email.text,
                              websiteURL: _websiteURL.text,
                              onDone: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
