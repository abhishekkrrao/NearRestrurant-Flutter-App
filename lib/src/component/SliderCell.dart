import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SlderCell extends StatelessWidget {
  SlderCell(this.image);
  @required
  final String image;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(PageRouteBuilder(
          //     opaque: false,
          //     pageBuilder: (BuildContext context, _, __) => DialogPage(image)));
        },
        child: Image(
          image: AssetImage(image),
          height: 100.0,
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
