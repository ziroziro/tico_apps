import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tico_apps/application/auth/bloc.dart';
import 'package:tico_apps/constant.dart';
import 'package:tico_apps/presentation/profile/about_us.dart';
import 'package:tico_apps/presentation/profile/forgot_password.dart';
import 'package:tico_apps/presentation/profile/set_dark_mode.dart';

import 'edit_profile_page.dart';

class ProfileForm extends StatelessWidget {
  final String username;
  final String email;
  final String school;
  final String role;
  final String kelas;
  const ProfileForm(
      {this.username, this.email, this.school, this.role, this.kelas});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: PADDING_PRIMARY, vertical: 28.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
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
                    Text(username, style: TextStyle(fontSize: 22)),
                    Text('Kelas: ' + kelas),
                    Text(role),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Text('Data Pribadi'),
            SizedBox(
              height: PADDING_PRIMARY,
            ),
            TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                icon: Icon(Icons.email),
                enabled: false,
                hintText: email,
              ),
            ),
            SizedBox(
              height: PADDING_PRIMARY,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      enabled: false,
                      hintText: 'Password',
                    ),
                  ),
                ),
                SizedBox(
                  width: PADDING_PRIMARY,
                ),
                RaisedButton(
                  child: Text(
                    'UBAH',
                    style: TextStyle(
                      color: LIGHT_BLUE,
                    ),
                  ),
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: LIGHT_BLUE),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  elevation: 0,
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => ForgotPassword()));
                  },
                )
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            Text('Lainnya'),
            SizedBox(
              height: PADDING_PRIMARY,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditProfilePage(
                      username: username,
                      email: email,
                      school: school,
                      role: role,
                      kelas: kelas,
                    ),
                  ),
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  enabled: false,
                  hintText: 'Edit Profil',
                ),
              ),
            ),
            SizedBox(
              height: PADDING_PRIMARY,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => SetDarkMode()));
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  enabled: false,
                  hintText: 'Set Dark Mode',
                ),
              ),
            ),
            SizedBox(
              height: PADDING_PRIMARY,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AboutUs(),
                  ),
                );
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  enabled: false,
                  hintText: 'Tentang Kami',
                ),
              ),
            ),
            SizedBox(
              height: PADDING_PRIMARY,
            ),
            InkWell(
              onTap: () {
                BlocProvider.of<AuthBloc>(context).dispatch(LoggedOut());
              },
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              child: TextFormField(
                readOnly: true,
                decoration: InputDecoration(
                  enabled: false,
                  hintText: 'Keluar',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
