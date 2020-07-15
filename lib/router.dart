import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:ido_explorer/screens/delegator_screen.dart';
import 'package:ido_explorer/screens/global_screen.dart';

class FluroRouter {
  static Router router = Router();

  static Handler _globalHandler =
      Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => GlobalScreen());
  static Handler _delegatorHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
          DelegatorScreen(address: params['address'][0]));

  static void setupRouter() {
    router.define('/', handler: _globalHandler, transitionType: TransitionType.fadeIn);

    router.define('/:address',
        handler: _delegatorHandler, transitionType: TransitionType.inFromRight);
  }
}
