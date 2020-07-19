import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchController = new TextEditingController();
    return Expanded(
      child: Container(
        height: 50,
        
        child: TextField(
          controller: searchController,
          style: TextStyle(color: Colors.deepPurple),
          maxLines: 1,
          decoration: InputDecoration(
              border: new OutlineInputBorder(borderRadius: const BorderRadius.all(const Radius.circular(0.0))),
              fillColor: Colors.white,
              hintText: 'Search by Address, Block height, TxHash',
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 1.0),
              ),
              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.grey[300], width: 0.0)),
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  print('WOWWWW');
                  print(searchController.text.toString());
                  if (searchController.text == null || searchController.text == "" || searchController.text == '' || searchController.text == "  ") {
                    print('NOTHING');
                  } else {
                    try {
                      Navigator.pushNamed(context, '${searchController.text}');
                    } catch (e) {
                      print(e + 'ghe');
                    }
                  }
                },
              )),
        ),
      ),
    );
  }
}
