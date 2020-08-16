import 'package:IDO_Kira/screens/delegator_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import 'screens/kira_screen.dart';

class FluroRouter {
  // Create the router
  static Router router = Router();

  // Create handler for each screen, this is where you can also add logic to URLs before processing them
  static Handler _kiraHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => KiraScreen());

  static Handler _delegatorHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => DelegatorScreen(address: params['address'][0]));

  //static Handler _delegatorHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => DelegatorScreen();)
  
  // Set up the routes, handler and it's transition
  static void setupRouter() {
    router.define('/', handler: _kiraHandler, transitionType: TransitionType.fadeIn);

    router.define('/:address', handler: _delegatorHandler, transitionType: TransitionType.fadeIn);
  }
}
