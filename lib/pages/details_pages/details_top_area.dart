import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_provide.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsProvide>(
      builder: (context, child, val) {
        var goodInfo = val.goodsInfo?.data?.goodInfo;
        if (goodInfo != null) {
          return Container(
            width: ScreenUtil.getInstance().setWidth(750),
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: <Widget>[
                _imageWidget(goodInfo.image1),
                _titleWidget(goodInfo.goodsName),
                _subTitleWidget(goodInfo.goodsSerialNumber),
                _priceWidget(goodInfo.presentPrice, goodInfo.oriPrice),
              ],
            ),
          );
        } else {
          return Text('正在加载中......');
        }
      },
    );
  }

  Widget _imageWidget(String url) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
//      height: ScreenUtil.getInstance().setHeight(1000),
      child: Image.network(url),
    );
  }

  Widget _titleWidget(String name) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Text(
        name,
        style: TextStyle(
          fontSize: ScreenUtil.getInstance().setSp(36),
        ),
      ),
    );
  }

  Widget _subTitleWidget(String code) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Text(
        '编号：$code',
        style: TextStyle(
          color: Colors.black45
        ),
      ),
    );
  }

  Widget _priceWidget(double presentPrice, double oriPrice) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(750),
      padding: EdgeInsets.only(left: 10.0, top: 5.0, bottom: 5.0),
      child: Row(
        children: <Widget>[
          Text(
            '￥$presentPrice',
            style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(36),
              color: Colors.pink,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 50.0),
            child: Text(
              '市场价：￥$oriPrice',
              style: TextStyle(
                color: Colors.black26,
                decoration: TextDecoration.lineThrough,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
