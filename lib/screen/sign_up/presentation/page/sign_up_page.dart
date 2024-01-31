import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/core/utiles/utility.dart';
import 'package:password/core/utiles/validation.dart';
import 'package:password/core/widgets/common_field.dart';
import 'package:password/screen/sign_up/presentation/bloc/sign_up_bloc.dart';
import 'package:password/screen/sign_up/presentation/bloc/sign_up_event.dart';
import 'package:password/screen/sign_up/presentation/bloc/sign_up_state.dart';
import 'package:password/screen/sign_up/presentation/widgets/error_msg.dart';
import 'package:password/screen/sign_up/presentation/widgets/have_account_text.dart';
import 'package:password/screen/sign_up/presentation/widgets/sign_up_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  late TextEditingController email, name, password, confirmPassword;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    email = TextEditingController();
    name = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Password Saver",
          style: TextStyle(),
        ),
      ),
      body: BlocBuilder<SignUpBloc, SignUpState>(
        builder: (context, state) {
          // state.isLoading ? Utility.loaderScreen() : Utility.loaderScreen();
          return LayoutBuilder(
            builder: (context, size) {
              return SizedBox(
                height: size.maxHeight,
                width: size.maxWidth,
                child: Form(
                  key: formKey,
                  child: Container(
                    width: size.maxWidth,
                    height: size.maxHeight,
                    padding: const EdgeInsets.all(8.0),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ErrorMsg(
                            isError: state.error,
                          ),
                          CommonField(
                            controller: name,
                            label: "Name",
                            validation: validateName,
                          ),
                          CommonField(
                            controller: email,
                            label: "Email",
                            validation: validateEmail,
                          ),
                          CommonField(
                            controller: password,
                            label: 'Password',
                            validation: validatePassword,
                          ),
                          CommonField(
                            controller: confirmPassword,
                            label: "Confirm Password",
                            arg: password.text,
                            validation: validateConfirmPassword,
                          ),
                          HaveAccountText(
                            tap: () {
                              Navigator.pushReplacementNamed(context, signInPageRoute);
                            },
                          ),
                          SignUpButton(
                            onPressed: () {
                              setState(() {
                                formKey.currentState!.validate();
                              });
                              context.read<SignUpBloc>().add(
                                    OnSignUpEvent(
                                      email: email.text,
                                      password: password.text,
                                      name: name.text,
                                      confirmPassword: confirmPassword.text,
                                      onDone: () {
                                        Navigator.pushReplacementNamed(context, homePageRoute);
                                      },
                                    ),
                                  );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
