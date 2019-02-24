import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _textEditingController = TextEditingController();
  String _showText = '欢迎来到天上人间';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('美好人间'),
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: <Widget>[
                TextField(
                  controller: _textEditingController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10.0),
                    labelText: '美女类型',
                    helperText: '请输入你喜欢的类型',
                  ),
                  autofocus: false,
                ),
                RaisedButton(
                  onPressed: _choiceAction,
                  child: Text('选择完毕'),
                ),
                Text(
                  _showText,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ),
        resizeToAvoidBottomPadding: false,
      ),
    );
  }

  void _choiceAction() {
    print('开始选择......................');
    if (_textEditingController.text.toString().isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text('美女类型不能为空')),
      );
    } else {
      _getHttp(_textEditingController.text.toString()).then((val) {
        setState(() {
          _showText = val['data']['name'].toString();
        });
      });
    }
  }

  Future _getHttp(String type) async {
    try {
      Response response;
      var data = {
        'name': type,
      };
      response = await Dio().get(
        'https://www.easy-mock.com/mock/5c60131a4bed3a6342711498/baixing/dabaojian',
        queryParameters: data,
      );
      return response.data;
    } catch (e) {
      return print('');
    }
  }
}

