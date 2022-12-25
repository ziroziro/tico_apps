import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/presentation/task/task_detail_card.dart';
import 'package:intl/intl.dart';

import '../../constant.dart';

class TaskCard extends StatelessWidget {
  final String judul;
  final String deskripsi;
  final Timestamp tanggal;
  final String role;
  final String school;
  final String kelas;
  final String nama;
  const TaskCard(
      {this.judul,
      this.deskripsi,
      this.tanggal,
      this.role,
      this.school,
      this.kelas,
      this.nama});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailCard(
              judul: judul,
              deskripsi: deskripsi,
              tanggal: tanggal,
              kelas: kelas,
              school: school,
              nama: nama,
              role: role,
            ),
          ),
        );
      },
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(judul),
                    Container(
                      width: MediaQuery.of(context).size.width / 2 * 1.5,
                      child: Text(
                        deskripsi,
                        style: TextStyle(
                          color: Colors.grey[600],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      'batas waktu: ' +
                          DateFormat(
                            "dd MM yyyy",
                          ).format(tanggal.toDate()).toString(),
                      style: TextStyle(color: DARK_GRAY),
                    ),
                  ],
                ),
                role == 'guru'
                    ? PopupMenuButton(
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            child: Text('hapus'),
                            value: 1,
                          ),
                        ],
                        icon: Icon(Icons.more_vert),
                        onSelected: (value) {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text(
                                      'anda yakin ingin menghapus tugas ini?'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('tidak'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        deleteData(school);
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('yakin'),
                                    )
                                  ],
                                );
                              });
                        },
                      )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteData(String school) {
    var map = new Map<String, dynamic>();
    map['judul'] = judul;
    map['deskripsi'] = deskripsi;
    map['waktu'] = tanggal;
    FirebaseFirestore.instance.collection('tugas').doc(school).set(
      {
        school: FieldValue.arrayRemove([map])
      },
      SetOptions(merge: true),
    );
  }
}
