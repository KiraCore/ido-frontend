import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HiddenCustomCard extends StatelessWidget {
  final Widget child;

  final Function() onTap;

  const HiddenCustomCard({Key key, this.child, this.onTap}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(child: Padding(child: child, padding: EdgeInsets.all(0)), onTap: onTap),
    );
  }
}
