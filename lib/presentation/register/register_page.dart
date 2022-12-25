import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tico_apps/application/register/register_bloc.dart';
import 'package:tico_apps/infrastructure/auth/user_repository.dart';
import 'package:tico_apps/presentation/register/register_form.dart';

class RegisterPage extends StatefulWidget {
  final UserRepository _userRepository;
  const RegisterPage({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  RegisterBloc _registerBloc;

  @override
  void initState() {
    super.initState();
    _registerBloc = RegisterBloc(userRepository: widget._userRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<RegisterBloc>(
        bloc: _registerBloc,
        child: RegisterForm(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _registerBloc.dispose();
  }
}
