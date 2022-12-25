import 'package:flutter/material.dart';
import 'package:tico_apps/infrastructure/auth/user_repository.dart';
import 'package:tico_apps/presentation/register/register_page.dart';

class CreateAccountButton extends StatelessWidget {
  final UserRepository _userRepository;

  CreateAccountButton({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Text(
        'Belum punya akun? Buat akun',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return RegisterPage(userRepository: _userRepository);
          }),
        );
      },
    );
  }
}
