import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import 'package:flutter_shop/config/httpHeader.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {

  String _showText = '请求返回数据';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('伪造请求头')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: _choiceAction,
              child: Text('发送请求'),
            ),
            Text(_showText),
          ],
        ),
      ),
    );
  }

  void _choiceAction() {
    _getHttp().then((val) {
      setState(() {
        _showText = val['data'].toString();
      });
    });
  }

  Future _getHttp() async {
    try {
      Response response;
      Dio dio = Dio();
      dio.options.headers = header;
      response = await dio.get('https://time.geekbang.org/serv/v1/column/newAll');
      return response.data;
    } catch (e) {
      return print('请求失败');
    }
  }
}

