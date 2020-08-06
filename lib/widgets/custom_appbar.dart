import 'package:IDO_Kira/widgets/ido_button.dart';
import 'package:IDO_Kira/widgets/search_bar.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //      shadowColor: Colors.grey,
      //      elevation: 3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0),
            spreadRadius: 5,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: EdgeInsets.only(top: 20, bottom: 10),

      height: 100,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Flexible(
                  child: FlatButton(
                    onPressed: () => Navigator.pushNamed(context, '/'),
                    child: Image(
                      image: AssetImage('ido_logo.PNG'),
                      height: 30,
                    ),
                  ),
                ),
                Expanded(child: SizedBox(height: 50, child: Searchbar())),
                Flexible(
                  child: SizedBox(
                    width: 130,
                    height: 50,
                    child: IdoButton(),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
