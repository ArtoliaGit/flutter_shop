import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../service/service_method.dart';
import '../model/category_model.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftWidget(),
            Container(),
          ],
        ),
      ),
    );
  }

}

class LeftWidget extends StatefulWidget {
  @override
  _LeftWidgetState createState() => _LeftWidgetState();
}

class _LeftWidgetState extends State<LeftWidget> {

  List<CategoryModel> list = [];

  @override
  void initState() {
    super.initState();
    getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(200),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _itemWidget(index);
        },
      ),
    );
  }

  Widget _itemWidget(int index) {
    return Container(
      height: ScreenUtil.getInstance().setHeight(100),
      padding: const EdgeInsets.only(left: 10.0),
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.black12,
          ),
        ),
      ),
      child: Text(
        list[index].mallCategoryName,
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(28)
        ),
      ),
    );
  }

  void getCategory() {
    request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryListModel categoryListModel = CategoryListModel.fromJson(data['data']);
      setState(() {
        list = categoryListModel.list;
      });
    });
  }
}

