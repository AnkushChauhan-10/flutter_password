import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:password/core/utiles/NetworkConnectivityController.dart';
import 'package:password/core/utiles/utility.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/features/password_generator/presentation/page/password_generator_page.dart';
import 'package:password/screen/save_data/presentation/bloc/save_bloc.dart';
import 'package:password/screen/save_data/presentation/bloc/save_event.dart';
import 'package:password/screen/save_data/presentation/bloc/save_state.dart';
import 'package:password/screen/save_data/presentation/widgets/save_button.dart';

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
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CommonField(
                      controller: _title,
                      label: "Title",
                      validation: validateName,
                    ),
                    CommonField(
                      controller: _userName,
                      label: "User Id",
                      validation: validateName,
                    ),
                    CommonField(
                      controller: _password,
                      label: "Password",
                      validation: validatePassword,
                    ),
                    PasswordGeneratorPage(
                      generatePassword: (password) {
                        setState(() {
                          _password.text = password;
                        });
                        print("=========================>>>> $password");
                      },
                    ),
                    GetBuilder<NetworkConnectivityController>(builder: (ctrl) {
                      return Opacity(
                        opacity: ctrl.connection ? 1 : 0.4,
                        child: SaveButton(
                          onPressed: ctrl.connection
                              ? () {
                                  _key.currentState?.validate();
                                  context.read<SaveBloc>().add(
                                        OnSave(
                                          title: _title.text,
                                          password: _password.text,
                                          userName: _userName.text,
                                          onDone: () {
                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                }
                              : () => Utility.toastMessage(title: "Network Error", message: "Please Check your network connection and try again!"),
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
