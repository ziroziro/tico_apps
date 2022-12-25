import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tico_apps/constant.dart';
import 'package:tico_apps/theme.dart';

class SetDarkMode extends StatelessWidget {
  const SetDarkMode({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pilih Mode'),
        leading: BackButton(
          color: LIGHT_BLUE,
        ),
      ),
      body: Consumer<ThemeNotifier>(
        builder: (context, theme, child) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: FlatButton(
                  onPressed: () => {
                    print('Set Dark theme'),
                    theme.setDarkMode(),
                    Navigator.of(context).pop(),
                  },
                  child: Row(
                    children: [
                      Icon(Icons.nightlight_round),
                      SizedBox(width: 10.0),
                      Text('Set Dark theme'),
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                child: FlatButton(
                  onPressed: () => {
                    print('Set Light Theme'),
                    theme.setLightMode(),
                    Navigator.of(context).pop(),
                  },
                  child: Row(
                    children: [
                      Icon(Icons.wb_sunny),
                      SizedBox(width: 10.0),
                      Text('Set Light Theme'),
                    ],
                  ),
                ),
              ),
              Divider(),
            ],
          );
        },
      ),
    );
  }
}
