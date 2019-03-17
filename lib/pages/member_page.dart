import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/countdown.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Provide<Countdown>(
          builder: (context, child, countdown) {
            return Text(
              '${countdown.value}',
              style: Theme.of(context).textTheme.display1,
            );
          },
        ),
      ),
    );
  }
}
