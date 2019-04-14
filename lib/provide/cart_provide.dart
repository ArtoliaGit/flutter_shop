import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CartProvide with ChangeNotifier {

  String cartInfo = '[]';

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    if (sp.containsKey('cartInfo')) {
      List<Map> tempList = (json.decode(sp.getString('cartInfo')) as List).cast();
      bool isHas = false;
      tempList = tempList.map((item) {
        if (item['goodsId'] == goodsId) {
          item['count'] += 1;
          isHas = true;
        }
        return item;
      }).toList();
      if (!isHas) {
        tempList.add({
          'goodsId': goodsId,
          'goodsName': goodsName,
          'count': count,
          'price': price,
          'images': images,
        });
      }
      cartInfo = json.encode(tempList).toString();
      print(cartInfo);
    } else {
      List<Map> tempList = [];
      tempList.add({
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
      });
      cartInfo = json.encode(tempList).toString();
      print(cartInfo);
    }
    sp.setString('cartInfo', cartInfo);
    notifyListeners();
  }

  remove() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
    notifyListeners();
  }

}