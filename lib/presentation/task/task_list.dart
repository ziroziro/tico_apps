import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/presentation/create/modal_add_task.dart';
import 'package:tico_apps/presentation/task/task_list_page.dart';

import '../widget/shimmer_loading_grid.dart';

class TaskList extends StatefulWidget {
  final bool isTaskPage;
  const TaskList({@required this.isTaskPage});

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth auth = FirebaseAuth.instance;
    User currentUser = auth.currentUser;
    String uid = currentUser.uid.toString();
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return FutureBuilder(
      future: users.doc(uid).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print('error');
        }
        if (snapshot.hasData && !snapshot.data.exists) {
          print('has data');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerLoadingGrid(
                intemCount: 3,
                width: double.infinity,
                height: MediaQuery.of(context).size.height * (9.5 / 100),
                borderRadius: 5.0,
                scrollDirection: Axis.vertical,
                padding: 10.0,
              ),
            ),
          );
        }
        Map<String, dynamic> data = snapshot.data.data();
        return Stack(
          children: [
            TaskListPage(
              school: data['school'],
              role: data['role'],
              kelas: data['kelas'],
              nama: data['displayName'],
            ),
            data['role'] == 'guru' && widget.isTaskPage == true
                ? Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      padding: EdgeInsets.all(20.0),
                      child: FloatingActionButton(
                        child: Icon(Icons.add),
                        onPressed: () {
                          modalCreateTask(
                              context, data['school'], data['kelas']);
                        },
                      ),
                    ),
                  )
                : Container()
          ],
        );
      },
    );
  }
}
