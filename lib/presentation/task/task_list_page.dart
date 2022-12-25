import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:tico_apps/presentation/task/task_card.dart';
import 'package:tico_apps/presentation/widget/empty_page.dart';
import 'package:tico_apps/presentation/widget/shimmer_loading_grid.dart';

class TaskListPage extends StatefulWidget {
  final String school;
  final String role;
  final String kelas;
  final String nama;
  TaskListPage({this.school, this.role, this.kelas, this.nama});

  @override
  TaskListPageState createState() => TaskListPageState();
}

class TaskListPageState extends State<TaskListPage> {
  String pageName = 'Tugas';

  ScrollController scrollController = ScrollController();

  CollectionReference users = FirebaseFirestore.instance.collection('tugas');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: users.doc(widget.school).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          print('no data');
          return EmptyPage(
            pageName: pageName,
          );
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
              ));
        }
        Map<String, dynamic> data = snapshot.data.data();
        List<dynamic> myMap = data[widget.kelas];
        return myMap?.isEmpty ?? true
            ? EmptyPage(
                pageName: pageName,
              )
            : Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: TaskCard(
                          judul: data[widget.kelas][index]['judul'],
                          deskripsi: data[widget.kelas][index]['deskripsi'],
                          tanggal: data[widget.kelas][index]['waktu'],
                          role: widget.role,
                          school: widget.school,
                          kelas: widget.kelas,
                          nama: widget.nama,
                        ),
                      );
                    },
                    itemCount: myMap.length,
                  ),
                ],
              );
      },
    );
  }
}
