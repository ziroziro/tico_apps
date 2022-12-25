import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/constant.dart';
import 'package:tico_apps/presentation/absent/absent_page.dart';

import 'package:intl/intl.dart';

class TaskDetailCard extends StatefulWidget {
  final String judul;
  final String deskripsi;
  final Timestamp tanggal;
  final String kelas;
  final String school;
  final String nama;
  final String role;
  const TaskDetailCard({
    this.judul,
    this.deskripsi,
    this.tanggal,
    this.kelas,
    this.school,
    this.nama,
    this.role,
  });

  @override
  State<TaskDetailCard> createState() => _TaskDetailCardState();
}

class _TaskDetailCardState extends State<TaskDetailCard> {
  @override
  Widget build(BuildContext context) {
    bool isClicked = true;
    DateTime dateTime = DateTime.parse(widget.tanggal.toDate().toString());
    var now = new DateTime.now();
    var earlier = dateTime.subtract(Duration(seconds: 5));

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: LIGHT_BLUE,
        ),
        title: Text('detail task'),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30, left: 20, right: 15),
            child: Text(
              widget.judul,
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 20, right: 15),
            child: Text(
              'batas waktu: ' +
                  DateFormat(
                    "dd MM yyyy",
                  ).format(widget.tanggal.toDate()).toString(),
              style: TextStyle(color: DARK_GRAY),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 15.0),
            width: MediaQuery.of(context).size.width,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7.27)),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Deskripsi',
                      style: TextStyle(color: DARK_GRAY),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.deskripsi),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: AbsentPage(
              school: widget.school,
              kelas: widget.kelas,
              pelajaran: widget.judul,
            ),
          ),
        ],
      ),
      bottomNavigationBar: earlier.isAfter(now) && widget.role == 'murid'
          ? Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                padding: EdgeInsets.all(16.0),
                color: LIGHT_BLUE,
                child:
                    Text('Absen', style: TextStyle(color: WHITE, fontSize: 16)),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                onPressed: () {
                  if (isClicked) {
                    isClicked = false;
                    addDataAbsen(
                        widget.school, widget.kelas, widget.nama, widget.judul);
                  }
                },
              ),
            )
          : Container(
              child: Text(''),
            ),
    );
  }

  void addDataAbsen(
      String school, String kelas, String nama, String pelajaran) {
    var map = new Map<String, dynamic>();
    DateTime now = DateTime.now();
    Timestamp timestamp = Timestamp.fromDate(now);
    map['nama'] = nama;
    map['pelajaran'] = pelajaran;
    map['tanggal'] = timestamp.toDate();
    FirebaseFirestore.instance.collection('absen').doc(school).set(
      {
        kelas: FieldValue.arrayUnion([map])
      },
      SetOptions(merge: true),
    );
  }
}
