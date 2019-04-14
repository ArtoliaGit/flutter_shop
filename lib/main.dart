import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:fluro/fluro.dart';

import 'pages/index_page.dart';
import 'provide/countdown.dart';
import 'provide/category_state.dart';
import 'provide/category_goods_provide.dart';
import 'provide/details_provide.dart';
import 'provide/cart_provide.dart';
import './routers/routes.dart';
import './routers/application.dart';

void main() {
  var countdown = Countdown();
  var category = CategoryState();
  var categoryGoods = CategoryGoodsProvide();
  var details = DetailsProvide();
  var cart = CartProvide();
  var providers = Providers();
  providers
    ..provide(Provider<Countdown>.value(countdown))
    ..provide(Provider<CategoryState>.value(category))
    ..provide(Provider<CategoryGoodsProvide>.value(categoryGoods))
    ..provide(Provider<DetailsProvide>.value(details))
    ..provide(Provider<CartProvide>.value(cart));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final Router router = Router();
    Routes.configureRoutes(router);
    Application.router = router;

    return Container(
      child: MaterialApp(
        title: '百姓生活+', // app名字
        debugShowCheckedModeBanner: false, // 取消ui界面debugger显示
        theme: ThemeData(
          primaryColor: Colors.pink, // 主题颜色
        ),
        home: IndexPage(),
        onGenerateRoute: Application.router.generator,
      ),
    );
  }
}
