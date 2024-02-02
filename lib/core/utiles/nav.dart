import 'package:flutter/cupertino.dart';
import 'package:password/core/utiles/const.dart';
import 'package:password/screen/account/presentation/page/edit_page.dart';
import 'package:password/screen/home/presentation/page/home_page.dart';
import 'package:password/screen/save_data/presentation/page/save_page.dart';
import 'package:password/screen/security/presentation/security_page.dart';
import 'package:password/screen/sign_in/presentation/page/sign_in_page.dart';
import 'package:password/screen/sign_up/presentation/page/sign_up_page.dart';
import 'package:password/screen/splash/presentation/page/splash_page.dart';

class Nav {
  static final _ins = Nav._Ins();

  Nav._Ins();

  BuildContext? _context;

  BuildContext get context => _context!;

  final Map<String, Widget> _routes = {
    splashPageRoute: const SplashPage(),
    signInPageRoute: const SignInPage(),
    signUpPageRoute: const SignUpPage(),
    homePageRoute: const HomePage(),
    savePageRoute: const SavePage(),
    editPageRoute: const EditPage(),
    securityPageRoute: const SecurityPage(),
  };

  factory Nav.of(BuildContext context) => _ins.._context = context;

  PageRouteBuilder _fadeTransition(String name, dynamic arg) => PageRouteBuilder(
        settings: RouteSettings(arguments: arg),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.1, end: 1).animate(
              CurvedAnimation(
                parent: animation,
                curve: Curves.easeInCirc,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return _routes[name]!;
        },
      );

  PageRouteBuilder _verticalTransition(String name, dynamic arg) => PageRouteBuilder(
        settings: RouteSettings(arguments: arg),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1.0, 1.0),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                curve: Curves.ease,
                parent: animation,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return _routes[name]!;
        },
      );

  PageRouteBuilder _horizontalTransition(String name, dynamic arg) => PageRouteBuilder(
        settings: RouteSettings(arguments: arg),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 1),
              end: Offset.zero,
            ).animate(
              CurvedAnimation(
                curve: Curves.ease,
                parent: animation,
              ),
            ),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
        pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
          return _routes[name]!;
        },
      );

  void pushNamed(String name, {dynamic arg}) {
    Navigator.pushNamed(context, name, arguments: arg);
  }

  void pop() {
    Navigator.pop(context);
  }

  void pushReplacementNamed(String name, {dynamic arg}) {
    Navigator.pushReplacementNamed(context, name, arguments: arg);
  }

  void pushNameReplacementFadeAnimation(String name, {dynamic arg}) {
    Navigator.of(context).pushReplacement(_fadeTransition(name, arg));
  }

  void pushNameFadeAnimation(String name, {dynamic arg}) {
    Navigator.of(context).push(_fadeTransition(name, arg));
  }

  void pushNameVerticalSlideAnimation(String name, {dynamic arg}) {
    Navigator.of(context).push(_verticalTransition(name, arg));
  }
  void pushNameHorizontalSlideAnimation(String name, {dynamic arg}) {
    Navigator.of(context).push(_horizontalTransition(name, arg));
  }
  void pushNameReplacementHorizontalSlideAnimation(String name, {dynamic arg}) {
    Navigator.of(context).pushReplacement(_horizontalTransition(name, arg));
  }
  void pushNameReplacementVerticalSlideAnimation(String name, {dynamic arg}) {
    Navigator.of(context).pushReplacement(_verticalTransition(name, arg));
  }
}
