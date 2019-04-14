import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';

import '../../provide/cart_provide.dart';
import '../../provide/details_provide.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    var goodInfo = Provide.value<DetailsProvide>(context).goodsInfo.data.goodInfo;
    var goodsId = goodInfo.goodsId;
    var goodsName = goodInfo.goodsName;
    var count = 1;
    var price = goodInfo.presentPrice;
    var images = goodInfo.image1;

    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      height: ScreenUtil.getInstance().setHeight(80),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {

            },
            child: Container(
              width: ScreenUtil.getInstance().setWidth(110),
              color: Colors.white,
              child: Icon(
                Icons.shopping_cart,
                size: 35,
                color: Colors.red,
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provide.value<CartProvide>(context).save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              width: ScreenUtil.getInstance().setWidth(320),
              height: ScreenUtil.getInstance().setHeight(80),
              color: Colors.green,
              alignment: Alignment.center,
              child: Text(
                '加入购物车',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.getInstance().setSp(28),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              Provide.value<CartProvide>(context).remove();
            },
            child: Container(
              width: ScreenUtil.getInstance().setWidth(320),
              height: ScreenUtil.getInstance().setHeight(80),
              color: Colors.red,
              alignment: Alignment.center,
              child: Text(
                '立即购买',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil.getInstance().setSp(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
