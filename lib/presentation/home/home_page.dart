import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tico_apps/presentation/profile/profile_card.dart';
import 'package:tico_apps/presentation/task/task_list.dart';

import '../../constant.dart';

class HomePage extends StatelessWidget {
  final String school;
  final String role;
  final String kelas;
  final String nama;
  const HomePage({this.school, this.role, this.kelas, this.nama});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tico'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 28.0),
            child: ProfileCard(),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: PADDING_PRIMARY, vertical: 10.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/task.svg',
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text(
                  'Tugas',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            child: TaskList(
              isTaskPage: false,
            ),
          ),
        ],
      ),
    );
  }
}
