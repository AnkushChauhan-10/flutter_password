import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/features/splash/presentation/bloc/splash_bloc.dart';
import 'package:password/features/splash/presentation/bloc/splash_event.dart';
import 'package:password/features/splash/presentation/bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(OnCompleteSplashEvent(onDone: (nextPage) {
      Navigator.pushReplacementNamed(context, nextPage);
    }));
    context.read<SplashBloc>().add(OnRetrievedUserSplashEvent(onDone: (nextPage) {
      Navigator.pushReplacementNamed(context, nextPage);
    }));
    return Scaffold(
      body: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.green,
          child: const Center(
            child: Text("Password"),
          ),
        );
      }),
    );
  }
}
