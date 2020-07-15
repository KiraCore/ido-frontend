import 'package:flutter/material.dart';

class ModalTrigger extends StatelessWidget {
  _showModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(35), topRight: Radius.circular(35))),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Center(child: Text('IDO Explainer'))],
              ));
        });
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: () => _showModalBottomSheet(context),
      child: Text('What is an IDO?'),
    );
  }
}
