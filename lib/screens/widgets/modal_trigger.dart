import 'package:flutter/material.dart';
import 'dart:html' as html;

class ModalTrigger extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: () => html.window.open('https://medium.com/kira-core/initial-delegator-offering-ido-b788c83c32d5', 'Kira IDO Explainer'),
        fillColor: Colors.deepPurple,
        highlightColor: Colors.deepPurple,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text('What is an IDO?',
              style: TextStyle(
                color: Colors.white,
              )),
        ));
  }
}
