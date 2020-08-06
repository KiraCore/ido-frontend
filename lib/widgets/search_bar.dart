import 'package:flutter/material.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Create the controller for the search text field
    TextEditingController searchController = new TextEditingController();

    return Column(
      children: [
        Container(
          child: TextField(
            controller: searchController,
            style: TextStyle(color: Colors.black),
            maxLines: 1,
            decoration: InputDecoration(
                hintText: 'Search by Address, Block height, TxHash',
                hintStyle: TextStyle(color: Colors.black54),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple[300]),
                ),
                focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                suffixIcon: IconButton(
                  icon: Icon(Icons.search),
                  color: Colors.deepPurple,
                  onPressed: () {
                    if (searchController.text == null || searchController.text == "" || searchController.text == '' || searchController.text == "  ") {
                    } else {
                      try {
                        Navigator.pushNamed(context, '${searchController.text}');
                      } catch (e) {
                        print(e);
                      }
                    }
                  },
                )),
          ),
        ),
      ],
    );
  }
}
