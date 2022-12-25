import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/presentation/profile/profile_form.dart';

class ProfilePage extends StatefulWidget {
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
          return Scaffold(
            appBar: AppBar(
              title: Text('Profil'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        Map<String, dynamic> data = snapshot.data.data();
        return Scaffold(
          appBar: AppBar(title: Text('Profil')),
          body: Container(
            child: ProfileForm(
              email: data['email'],
              username: data['displayName'],
              school: data['school'],
              role: data['role'],
              kelas: data['kelas'],
            ),
          ),
        );
      },
    );
  }
}
