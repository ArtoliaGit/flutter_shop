import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/details_entity.dart';
import '../service/service_method.dart';

class DetailsProvide with ChangeNotifier {

  DetailsEntity goodsInfo = null;

  int tabIndex = 0;

  getDetailsData(String goodsId) async {
    goodsInfo = null;
    tabIndex = 0;
    var formData = {
      "goodId": goodsId,
    };
    await request('getGoodDetailById', formData: formData).then((res) {
      var responseData = json.decode(res.toString());
      goodsInfo = DetailsEntity.fromJson(responseData);
      notifyListeners();
    });
  }

  changeTabIndex(int tabIndex) {
    this.tabIndex = tabIndex;
    notifyListeners();
  }
}