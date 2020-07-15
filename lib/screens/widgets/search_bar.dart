import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 50,
        child: TextField(
          onSubmitted: (value) {
            Navigator.pushNamed(context, '$value');
          },
          style: GoogleFonts.sourceSansPro(textStyle: TextStyle(color: Colors.purple)),
          maxLines: 1,
          decoration: InputDecoration(
            hintText: 'Search by Address, Block height, TxHash',
            contentPadding: EdgeInsets.symmetric(vertical: 0),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.purple[300], width: 0.0),
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300], width: 0.0)),
            prefixIcon: Icon(
              Icons.search,
              size: 20,
            ),
          ),
        ),
      ),
    );
  }
}
