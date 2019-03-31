import 'package:flutter/material.dart';
import '../model/mall_goods_entity.dart';

class CategoryGoodsProvide with ChangeNotifier {

  List<MallGoodsData> list = [];

  getMallGoodsList(List<MallGoodsData> list) {
    this.list = list;
    notifyListeners();
  }

  getMoreMallGoodsList(List<MallGoodsData> list) {
    this.list.addAll(list);
    notifyListeners();
  }
}