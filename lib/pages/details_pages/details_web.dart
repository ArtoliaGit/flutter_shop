import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_provide.dart';

class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsProvide>(
      builder: (context, child, val) {
        
        if (val.tabIndex == 0) {
          return Container(
            child: Html(
              data: val.goodsInfo.data.goodInfo.goodsDetail,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil.getInstance().setWidth(750),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂时没有数据'),
          );
        }
        
      },
    );
  }
}
