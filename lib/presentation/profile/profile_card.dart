import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tico_apps/presentation/widget/shimmer_loading_grid.dart';

import '../../constant.dart';

class ProfileCard extends StatefulWidget {
  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
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
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: ShimmerLoadingGrid(
                  shinkWrap: false,
                  aspecRatio: 4.5,
                  intemCount: 1,
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * (9.5 / 100),
                  borderRadius: 5.0,
                  scrollDirection: Axis.vertical,
                  padding: 10.0,
                ),
              ),
            ),
          );
        }
        Map<String, dynamic> data = snapshot.data.data();
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              children: [
                SvgPicture.asset(
                  'assets/icons/profile.svg',
                  width: 60,
                  height: 61,
                ),
                SizedBox(width: PADDING_PRIMARY),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['displayName'],
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data['kelas'],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
