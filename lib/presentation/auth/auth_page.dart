import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tico_apps/application/auth/bloc.dart';
import 'package:tico_apps/infrastructure/auth/user_repository.dart';
import 'package:tico_apps/presentation/login/login_page.dart';
import 'package:tico_apps/presentation/nav_bar/bottom_navbar.dart';
import 'package:tico_apps/presentation/splashscreen/splashscreen.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final UserRepository _userRepository = UserRepository();
  AuthBloc _authBloc;

  @override
  void initState() {
    super.initState();
    _authBloc = AuthBloc(userRepository: _userRepository);
    _authBloc.dispatch(AppStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      bloc: _authBloc,
      child: Scaffold(
        body: BlocBuilder(
          bloc: _authBloc,
          builder: (BuildContext context, AuthState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            }
            if (state is UnAuthenticated) {
              return LoginPage(userRepository: _userRepository);
            }
            if (state is Authenticated) {
              return PageNavigation();
            }
            return PageNavigation();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _authBloc.dispose();
  }
}
