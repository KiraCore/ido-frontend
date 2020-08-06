import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class IdoButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: RaisedButton(
          onPressed: _launchURL, //=> html.window.open('https://medium.com/kira-core/initial-delegator-offering-ido-b788c83c32d5', 'Kira IDO Explainer'),
          color: Colors.amber,
          //focusColor: Colors.pink,
          hoverColor: Colors.white,
          highlightColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Text('What is an IDO?',
              style: TextStyle(
                color: Colors.black,
              )),
        ),
      ),
    );
  }

  _launchURL() async {
    const url = 'https://medium.com/kira-core/initial-delegator-offering-ido-b788c83c32d5';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
