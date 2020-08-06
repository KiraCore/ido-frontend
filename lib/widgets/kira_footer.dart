import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class KiraFooter extends StatelessWidget {
  const KiraFooter({
    Key key,
  }) : super(key: key);

  _launchSocials(String name) async {
    switch (name) {
      case 'telegram':
        const url = 'https://t.me/kirainterex';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      case 'twitter':
        const url = 'https://twitter.com/kira_core';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      case 'github':
        const url = 'https://github.com/KiraCore';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }

        break;
      case 'medium':
        const url = 'https://medium.com/kira-core';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
      case 'email':
        const url = 'mailto:partners@kiracore.com';
        if (await canLaunch(url)) {
          await launch(url);
        } else {
          throw 'Could not launch $url';
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(top: 20, bottom: 10),
        color: Colors.black87,
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  children: [
                    FlatButton(
                      onPressed: () => Navigator.pushNamed(context, '/'),
                      child: Image(
                        image: AssetImage('ido_logotwo.PNG'),
                        height: 30,
                      ),
                    )
                  ],
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.twitter,
                              color: Colors.white,
                            ),
                            onPressed: () => _launchSocials('twitter')),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.github,
                              color: Colors.white,
                            ),
                            onPressed: () => _launchSocials('github')),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.mediumM,
                              color: Colors.white,
                            ),
                            onPressed: () => _launchSocials('medium')),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.telegram,
                              color: Colors.white,
                            ),
                            onPressed: () => _launchSocials('telegram')),
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.solidEnvelope,
                              color: Colors.white,
                            ),
                            onPressed: () => _launchSocials('email')),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text('KIRACORE COPYRIGHT 2020', style: TextStyle(color: Colors.grey[600])),
            )
          ],
        ));
  }
}
