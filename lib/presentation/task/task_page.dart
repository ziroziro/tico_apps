import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/presentation/task/task_list.dart';

class TaskPage extends StatelessWidget {
  const TaskPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tugas'),
      ),
      body: Container(
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              child: TaskList(isTaskPage: true),
            ),
          ],
        ),
      ),
    );
  }
}
