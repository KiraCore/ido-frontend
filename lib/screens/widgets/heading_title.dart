import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeadingTitle extends StatelessWidget {
  const HeadingTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '· KIRA - Interchain Mining Event ·',
            style: TextStyle(color: Colors.black, fontSize: 24),
          )
        ],
      ),
    );
  }
}
