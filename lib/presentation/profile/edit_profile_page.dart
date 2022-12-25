import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tico_apps/constant.dart';

class EditProfilePage extends StatelessWidget {
  final String username;
  final String email;
  final String school;
  final String role;
  final String kelas;
  const EditProfilePage({
    this.username,
    this.email,
    this.role,
    this.school,
    this.kelas,
  });

  @override
  Widget build(BuildContext context) {
    TextEditingController _usernameController =
        TextEditingController(text: username ?? 'kosong');
    TextEditingController _kelasController =
        TextEditingController(text: kelas ?? 'kosong');
    String newUsername = '';
    String newKelas = '';

    void updateData(String myNama, String myKelas) {
      FirebaseAuth auth = FirebaseAuth.instance;
      User currentUser = auth.currentUser;
      String uid = currentUser.uid.toString();
      FirebaseFirestore.instance.collection('users').doc(uid).update({
        'displayName': myNama,
        'kelas': myKelas,
      }).then(
          (value) => print('{new user: username: $myNama, kelas: $myKelas}'));
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit profile'),
        leading: BackButton(
          color: LIGHT_BLUE,
        ),
      ),
      body: Container(
        child: Form(
          // key: _formKey,
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('username'),
                      TextFormField(
                        controller: _usernameController,
                        onChanged: (value) {
                          newUsername = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'masukkan nama anda',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('kelas'),
                      TextFormField(
                        textCapitalization: TextCapitalization.characters,
                        controller: _kelasController,
                        onChanged: (value) {
                          newKelas = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'masukkan nama anda',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('email'),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: email,
                          enabled: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('asal sekolah'),
                      TextFormField(
                        readOnly: true,
                        decoration: InputDecoration(
                          enabled: false,
                          hintText: school,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(PADDING_PRIMARY),
          child: RaisedButton(
            padding: EdgeInsets.all(16.0),
            color: LIGHT_BLUE,
            child: Text('Submit', style: TextStyle(color: WHITE, fontSize: 16)),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
            onPressed: () {
              updateData(newUsername != '' ? newUsername : username,
                  newKelas != '' ? newKelas : kelas);
              Navigator.of(context).pop();
            },
          ),
        ),
      ),
    );
  }
}
