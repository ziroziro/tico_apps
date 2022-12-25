import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/presentation/widget/empty_page.dart';
import 'package:tico_apps/presentation/task/task_card.dart';
import 'package:tico_apps/presentation/widget/shimmer_loading_grid.dart';

import '../../constant.dart';

class AbsentPage extends StatefulWidget {
  final String school;
  final String role;
  final String kelas;
  final String pelajaran;
  const AbsentPage(
      {Key key, @required this.school, this.role, this.kelas, this.pelajaran})
      : super(key: key);

  @override
  _AbsentPageState createState() => _AbsentPageState();
}

class _AbsentPageState extends State<AbsentPage> {
  String pageName = 'Absen';
  ScrollController scrollController = ScrollController();
  CollectionReference users = FirebaseFirestore.instance.collection('absen');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: users.doc(widget.school).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }

        if (snapshot.hasData && !snapshot.data.exists) {
          print('no data');
          return Container();
          // EmptyPage(
          //   pageName: pageName,
          // );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ShimmerLoadingGrid(
                intemCount: 1,
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
        List<dynamic> myClass = data[widget.kelas];
        return myClass?.isEmpty ?? true
            ? Container()
            : Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(7.27)),
                child: Container(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Absen',
                        style: TextStyle(color: DARK_GRAY),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return data[widget.kelas][index]['pelajaran'] ==
                                  widget.pelajaran
                              ? Container(
                                  child: Text(
                                    data[widget.kelas][index]['nama'],
                                  ),
                                )
                              : Container();
                        },
                        itemCount: data[widget.kelas].length,
                      ),
                    ],
                  ),
                ),
              );
        // );
      },
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:tico_apps/constant.dart';
// import 'package:tico_apps/presentation/absent/absent_card.dart';
// import 'package:tico_apps/presentation/task/task_card.dart';

// import '../empty_page.dart';

// class AbsentPage extends StatefulWidget {
//   final String school;
//   final String role;
//   const AbsentPage({Key key, this.school, this.role}) : super(key: key);

//   @override
//   _AbsentPageState createState() => _AbsentPageState();
// }

// class _AbsentPageState extends State<AbsentPage> {
//   String pageName = 'Absen';
//   ScrollController scrollController = ScrollController();
//   CollectionReference users = FirebaseFirestore.instance.collection('absen');

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(widget.school).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }

//         if (snapshot.hasData && !snapshot.data.exists) {
//           print('no data');
//           return EmptyPage(
//             pageName: pageName,
//           );
//         }
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Scaffold(
//             body: Center(
//               child: CircularProgressIndicator(),
//             ),
//           );
//         }
//         Map<String, dynamic> data = snapshot.data.data();
//         List<dynamic> myMap = data['12 rpl b'];
//         return
//             // myMap?.isEmpty ?? true
//             //     ? EmptyPage(
//             //         pageName: pageName,
//             //       )
//             //     :
//             Column(
//           children: [
//             ListView.builder(
//               shrinkWrap: true,
//               controller: scrollController,
//               itemBuilder: (context, index) {
//                 return Container(
//                   child: AbsentCard(),
//                   // child: TaskCard(
//                   //   judul: data[widget.school][index]['judul'],
//                   //   deskripsi: data[widget.school][index]['deskripsi'],
//                   //   tanggal: data[widget.school][index]['waktu'],
//                   //   role: widget.role,
//                   //   school: widget.school,
//                   // ),
//                 );
//               },
//               itemCount: data[widget.school].length,
//             ),
//           ],
//         );
//         // );
//       },
//     );
//   }
// }

// // class AbsentPage extends StatefulWidget {
// //   const AbsentPage({Key key}) : super(key: key);

// //   @override
// //   _AbsentPageState createState() => _AbsentPageState();
// // }

// // class _AbsentPageState extends State<AbsentPage> {
// //   ScrollController scrollController = ScrollController();
// //   final Stream<QuerySnapshot> _stream =
// //       FirebaseFirestore.instance.collection('absen').snapshots();

// //   @override
// //   Widget build(BuildContext context) {
// //     return StreamBuilder<QuerySnapshot>(
// //       stream: _stream,
// //       builder: (context, snapshot) {
// //         if (snapshot.hasError && snapshot.hasData) {
// //           print('ada yang salah');
// //         }
// //         if (snapshot.connectionState == ConnectionState.waiting) {
// //           return Center(
// //             child: CircularProgressIndicator(),
// //           );
// //         }
// //         return CustomScrollView(
// //           slivers: [
// //             SliverList(
// //               delegate: SliverChildBuilderDelegate(
// //                 (BuildContext context, int index) {
// //                   return Container(
// //                     padding: EdgeInsets.symmetric(
// //                       horizontal: PADDING_PRIMARY,
// //                       vertical: 8.0,
// //                     ),
// //                     child: AbsentCard(
// //                       absen: snapshot.data.docs[index]['absen'],
// //                       tanggal: snapshot.data.docs[index]['tanggal'].toString(),
// //                     ),
// //                   );
// //                 },
// //                 childCount: snapshot.data.size,
// //               ),
// //             ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
