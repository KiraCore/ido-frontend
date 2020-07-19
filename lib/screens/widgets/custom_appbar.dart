import 'package:flutter/material.dart';
import 'package:ido_explorer/screens/widgets/modal_trigger.dart';

import 'package:ido_explorer/screens/widgets/search_bar.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Flexible(child: FlatButton(onPressed: () => Navigator.pushNamed(context, '/'), child: Image(image: AssetImage('ido_logo-min.png')))),

        Expanded(child: SizedBox(width: 200, child: Searchbar())),

        Theme(
          data: Theme.of(context).copyWith(canvasColor: Colors.transparent),
          child: ModalTrigger(),
        )

        //Menu item can be added here
      ],
    );
  }
}
