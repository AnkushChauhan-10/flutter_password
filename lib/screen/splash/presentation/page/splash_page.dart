import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password/screen/splash/presentation/bloc/splash_bloc.dart';
import 'package:password/screen/splash/presentation/bloc/splash_event.dart';
import 'package:password/screen/splash/presentation/bloc/splash_state.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  late final AnimationController _fadeController;
  late final Animation<double> _fadeAnimation;

  String nextPage = "";
  bool isCompleted = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _fadeController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.fastOutSlowIn,
    );
    _controller.forward();
    _controller.addListener(() {
      _controller.isCompleted ? isCompleted = true : null;
      if (nextPage.isNotEmpty) {
        if(_controller.value <= 0.1 && isCompleted) {
          Navigator.pushReplacementNamed(context, nextPage);
        }else{
          _controller.isAnimating ? null : _controller.reverse();
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.read<SplashBloc>().add(OnRetrievedUserSplashEvent(onDone: (page) {
      nextPage = page;
      print("page");
      if (_controller.isCompleted) _controller.reverse();
    }));
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.black,
                    Color.fromRGBO(3, 17, 54, 1.0),
                    Color.fromRGBO(5, 26, 73, 1.0),
                  ],
                ),
              ),
              child: Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: const Text(
                    "Password",
                    style: TextStyle(fontSize: 25,color: Colors.white),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
