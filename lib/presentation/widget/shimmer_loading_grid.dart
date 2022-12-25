import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tico_apps/domain/shared_preference_model.dart';

class ShimmerLoadingGrid extends StatelessWidget {
  final double height;
  final double width;
  final double padding;
  final double borderRadius;
  final double aspecRatio;
  final int intemCount;
  final String type;
  final bool shinkWrap;
  final Axis scrollDirection;

  const ShimmerLoadingGrid({
    Key key,
    this.type = 'list',
    this.borderRadius = 20,
    this.aspecRatio = 2,
    this.intemCount = 5,
    this.padding = 1.5,
    @required this.height,
    @required this.width,
    this.shinkWrap = true,
    this.scrollDirection = Axis.horizontal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: StorageManager.readData('themeMode'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Shimmer.fromColors(
                baseColor: snapshot.data == 'light'
                    ? Colors.grey[300]
                    : Colors.grey[800],
                highlightColor: snapshot.data == 'light'
                    ? Colors.grey[100]
                    : Colors.grey[600],
                enabled: true,
                child: (type == 'list')
                    ? Container(
                        width: double.infinity,
                        child: AspectRatio(
                            aspectRatio: aspecRatio,
                            child: ListView.builder(
                              itemCount: intemCount,
                              shrinkWrap: shinkWrap,
                              scrollDirection: scrollDirection,
                              physics: ClampingScrollPhysics(),
                              padding: EdgeInsets.zero,
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                padding: scrollDirection == Axis.horizontal
                                    ? EdgeInsets.only(right: padding, left: 0)
                                    : EdgeInsets.only(bottom: padding),
                                child: Column(
                                  children: <Widget>[
                                    ClipRRect(
                                      borderRadius: new BorderRadius.circular(
                                          borderRadius),
                                      child: Container(
                                        color: snapshot.data == 'light'
                                            ? Colors.white
                                            : Colors.black,
                                        width: width,
                                        height: height,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                      )
                    : Container());
          }
          return Container();
        });
  }
}
