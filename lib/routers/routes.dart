import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';

import './router_handler.dart';

class Routes {

  static final String root = '/';
  static final String detailsPage = '/detail';

  static void configureRoutes(Router router) {
    router.notFoundHandler = Handler(
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('404 NOT FOUND');
      },
    );

    router.define(detailsPage, handler: detailsHandler);
  }
}