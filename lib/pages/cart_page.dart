import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/countdown.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NumberWidget(),
            ButtonWidget(),
          ],
        ),
      ),
    );
  }
}

class NumberWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Provide<Countdown>(
        builder: (context, child, countdown) {
          return Text(
            '${countdown.value}',
            style: Theme.of(context).textTheme.display1,
          );
        },
      ),
    );
  }
}

class ButtonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: RaisedButton(
        onPressed: () {
          Provide.value<Countdown>(context).increament();
        },
        child: Text('递增'),
      ),
    );
  }
}

