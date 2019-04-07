import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../provide/details_provide.dart';

class DetailsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsProvide>(
      builder: (context, child, val) {
        return Container(
          width: ScreenUtil.getInstance().setWidth(750),
          margin: EdgeInsets.only(top: 10.0),
          child: Row(
            children: <Widget>[
              _itemWidget(context, '详情', 0, val.tabIndex),
              _itemWidget(context, '评论', 1, val.tabIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _itemWidget(BuildContext context, String tabName, int index, int tabIndex) {
    return Expanded(
      flex: 1,
      child: InkWell(
        onTap: () {
          Provide.value<DetailsProvide>(context).changeTabIndex(index);
        },
        child: Container(
//          width: ScreenUtil.getInstance().setWidth(375),
          height: ScreenUtil.getInstance().setHeight(100),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                color: tabIndex == index ? Colors.pink : Colors.black12,
                width: 1.0,
              ),
            ),
          ),
          child: Text(
            tabName,
            style: TextStyle(
              color: tabIndex == index ? Colors.pink : Colors.black,
              fontSize: ScreenUtil.getInstance().setSp(36),
            ),
          ),
        ),
      ),
    );
  }
}
