import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../service/service_method.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('百姓生活+'),
      ),
      body: FutureBuilder(
        future: getHomePageContent(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var data = json.decode(snapshot.data.toString());
            List<Map> swiper = (data['data']['slides'] as List).cast();
            List<Map> navigatorList = (data['data']['category'] as List).cast();
            String adPicture = data['data']['advertesPicture']['PICTURE_ADDRESS'];
            String leaderImage = data['data']['shopInfo']['leaderImage'];
            String leaderPhone = data['data']['shopInfo']['leaderPhone'];
            return Column(
              children: <Widget>[
                _SwiperDiy(swiperList: swiper),
                _TopNavigator(navigatorList: navigatorList),
                _AdBanner(adPicture: adPicture),
                _LeaderPhone(leaderImage: leaderImage, leaderPhone: leaderPhone),
              ],
            );
          } else {
            return Center(
              child: Text('加载中..........'),
            );
          }
        },
      ),
    );
  }
}

class _SwiperDiy extends StatelessWidget {

  final List swiperList;

  _SwiperDiy({Key key, @required this.swiperList}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Container(
      height: ScreenUtil.getInstance().setHeight(333),
      width: ScreenUtil.getInstance().setWidth(750),
      child: Swiper(
        itemBuilder: (context, index) {
          return Image.network('${swiperList[index]['image']}', fit: BoxFit.fill);
        },
        itemCount: swiperList.length,
        pagination: SwiperPagination(),
        autoplay: true,
      ),
    );
  }
}

class _TopNavigator extends StatelessWidget {

  final List navigatorList;

  _TopNavigator({Key key, this.navigatorList}) : super(key: key);

  Widget _gridViewItemUI(BuildContext context, Map item) {
    return InkWell(
      onTap: () {
        print('点击');
      },
      child: Column(
        children: <Widget>[
          Image.network(item['image'], width: ScreenUtil.getInstance().setWidth(95)),
          Text(item['mallCategoryName']),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (navigatorList.length > 10) {
      navigatorList.removeRange(10, navigatorList.length);
    }

    return Container(
      height: ScreenUtil.getInstance().setHeight(320),
      padding: const EdgeInsets.all(3.0),
      child: GridView.count(
        crossAxisCount: 5,
        padding: const EdgeInsets.all(5.0),
        children: navigatorList.map((item) {
          return _gridViewItemUI(context, item);
        }).toList(),
      ),
    );
  }
}

class _AdBanner extends StatelessWidget {
  final String adPicture;

  _AdBanner({Key key, this.adPicture}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.network(adPicture),
    );
  }
}

class _LeaderPhone extends StatelessWidget {
  final String leaderImage;
  final String leaderPhone;

  _LeaderPhone({Key key, this.leaderImage, this.leaderPhone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: _callPhone,
        child: Image.network(leaderImage),
      ),
    );
  }

  void _callPhone() async {
    String tel = 'tel:$leaderPhone';
    if (await canLaunch(tel)) {
      await launch(tel);
    } else {
      throw Exception('拨打电话失败');
    }
  }
}

