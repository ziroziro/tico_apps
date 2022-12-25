import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/constant.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback _onPressed;
  const LoginButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(16.0),
      color: LIGHT_BLUE,
      child: Text('Masuk', style: TextStyle(color: WHITE, fontSize: 16)),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: _onPressed != null ? _onPressed : () {},
    );
  }
}
