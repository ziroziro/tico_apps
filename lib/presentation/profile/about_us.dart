import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tico_apps/constant.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: LIGHT_BLUE,
        ),
        title: Text('Tentang Kami'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: PADDING_PRIMARY, top: 28.0),
                child: Text('Developer'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: PADDING_PRIMARY, vertical: 28.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/images/dzikri.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: PADDING_PRIMARY),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dzikri Rofa', style: TextStyle(fontSize: 22)),
                        Text(
                          'Mobile Developer',
                          style: TextStyle(color: DARK_GRAY),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/images/dzikri.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: PADDING_PRIMARY),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dzikri Rofa', style: TextStyle(fontSize: 22)),
                        Text(
                          'Designer UI UX',
                          style: TextStyle(color: DARK_GRAY),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: PADDING_PRIMARY, top: 28.0),
                child: Text('team'),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: PADDING_PRIMARY, vertical: 28.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(100.0),
                      child: Image.asset(
                        'assets/images/dzikri.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                    SizedBox(width: PADDING_PRIMARY),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Dzikri Rofa', style: TextStyle(fontSize: 22)),
                        Text(
                          'team',
                          style: TextStyle(color: DARK_GRAY),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
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
                        Text('Rahmananda', style: TextStyle(fontSize: 22)),
                        Text(
                          'team',
                          style: TextStyle(color: DARK_GRAY),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: PADDING_PRIMARY, vertical: 28.0),
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
                        Text('Tsabit Farel', style: TextStyle(fontSize: 22)),
                        Text(
                          'team',
                          style: TextStyle(color: DARK_GRAY),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: PADDING_PRIMARY),
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
                        Text('Razka Alehira', style: TextStyle(fontSize: 22)),
                        Text(
                          'team',
                          style: TextStyle(color: DARK_GRAY),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
