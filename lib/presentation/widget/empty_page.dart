import 'package:flutter/cupertino.dart';
import 'package:tico_apps/constant.dart';

class EmptyPage extends StatelessWidget {
  final String pageName;
  const EmptyPage({Key key, @required this.pageName});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/no_data.png',
            width: MediaQuery.of(context).size.width / 1,
            height: MediaQuery.of(context).size.width / 2,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            pageName + ' Masih Kosong' ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.0,
              color: LIGHT_BLUE,
            ),
          ),
        ],
      ),
    );
  }
}
