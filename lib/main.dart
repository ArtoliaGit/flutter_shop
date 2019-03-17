import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import 'pages/index_page.dart';
import 'provide/countdown.dart';

void main() {
  var countdown = Countdown();
  var providers = Providers();
  providers..provide(Provider<Countdown>.value(countdown));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+', // app名字
        debugShowCheckedModeBanner: false, // 取消ui界面debugger显示
        theme: ThemeData(
          primaryColor: Colors.pink, // 主题颜色
        ),
        home: IndexPage(),
      ),
    );
  }
}
