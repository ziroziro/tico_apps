import 'package:flutter/material.dart';
import 'package:tico_apps/constant.dart';

class RegisterButton extends StatelessWidget {
  final VoidCallback _onPressed;

  RegisterButton({Key key, VoidCallback onPressed})
      : _onPressed = onPressed,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(16.0),
      color: LIGHT_BLUE,
      child: Text('Daftar', style: TextStyle(color: WHITE, fontSize: 16)),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.0),
      ),
      onPressed: _onPressed != null
          ? _onPressed
          : () {
              Scaffold.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Kolom tidak boleh kosong'),
                        Icon(Icons.error),
                      ],
                    ),
                    // backgroundColor: Colors.red,
                  ),
                );
            },
    );
  }
}
