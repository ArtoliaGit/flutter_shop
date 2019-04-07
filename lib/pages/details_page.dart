import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

import '../provide/details_provide.dart';
import './details_pages/details_top_area.dart';
import './details_pages/details_explain.dart';
import './details_pages/details_tab.dart';
import './details_pages/details_web.dart';

class DetailsPage extends StatelessWidget {

  String goodsId;

  DetailsPage(this.goodsId);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('商品详情'),
        ),
        body: FutureBuilder(
          future: _getGoodsInfo(context),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                child: ListView(
                  children: <Widget>[
                    DetailsTopArea(),
                    DetailsExpalin(),
                    DetailsTab(),
                    DetailsWeb(),
                  ],
                )
              );
            } else {
              return Text('加载中...');
            }
          },
        ),
      ),
    );
  }

  Future _getGoodsInfo(BuildContext context) async {
    await Provide.value<DetailsProvide>(context).getDetailsData(goodsId);
    return '完成加载';
  }
}
