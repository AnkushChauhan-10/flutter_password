import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_bloc.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_event.dart';
import 'package:password/screen/sign_in/presentation/bloc/sign_in_state.dart';
import 'package:password/screen/sign_in/presentation/widgets/error_msg.dart';
import 'package:password/screen/sign_in/presentation/widgets/not_have_account_text.dart';
import 'package:password/screen/sign_in/presentation/widgets/sign_in_button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  late TextEditingController email, name, password, phone;
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    phone = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Password Saver",
            style: TextStyle(),
          ),
        ),
      ),
      body: BlocBuilder<SignInBloc, SignInState>(
        builder: (context, state) {
          return LayoutBuilder(builder: (context, size) {
            return Form(
              key: formKey,
              child: Center(
                child: SizedBox(
                  height: size.maxHeight,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ErrorMsg(isError: state.error),
                          Flexible(
                            child: CommonField(
                              controller: email,
                              label: 'Email',
                              validation: validateEmail,
                            ),
                          ),
                          Flexible(
                            child: CommonField(
                              controller: password,
                              label: 'Password',
                              validation: validatePassword,
                            ),
                          ),
                          Flexible(
                            child: NotHaveAccountText(
                              tap: () {
                                Navigator.pushReplacementNamed(context, signUpPageRoute);
                              },
                            ),
                          ),
                          Flexible(
                            child: SignInButton(
                              onPressed: () {
                                setState(() {
                                  formKey.currentState!.validate();
                                });
                                context.read<SignInBloc>().add(
                                  OnSignInEvent(
                                    email: email.text,
                                    password: password.text,
                                    onDone: () {
                                      Navigator.pushReplacementNamed(context, homePageRoute);
                                    },
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
