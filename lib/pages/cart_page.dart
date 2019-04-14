import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {

  List<String> tempList = [];

  @override
  Widget build(BuildContext context) {
    _show();
    return Scaffold(
      body: Column(
        children: <Widget>[
          Container(
            width: ScreenUtil.getInstance().setWidth(750),
            height: ScreenUtil.getInstance().setHeight(500),
            child: ListView.builder(
              itemCount: tempList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(tempList[index]),
                );
              },
            ),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('增加'),
                onPressed: () {
                  _add();
                },
              ),
              RaisedButton(
                child: Text('清除'),
                onPressed: () {
                  _clear();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _add() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    tempList.add('123');
    sp.setStringList('tempList', tempList);
    _show();
  }

  void _show() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    if (sp.containsKey('tempList')) {
      setState(() {
        tempList = sp.getStringList('tempList');
      });
    }
  }

  void _clear() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove('tempList');
    setState(() {
      tempList = [];
    });
  }
}
