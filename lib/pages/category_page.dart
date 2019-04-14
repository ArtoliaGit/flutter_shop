import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../service/service_method.dart';
import '../model/category_entity.dart';
import '../model/mall_goods_entity.dart';
import '../provide/category_state.dart';
import '../provide/category_goods_provide.dart';
import '../routers/application.dart';

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
            Column(
              children: <Widget>[
                RightContentNav(),
                Expanded(
                  child: MallGoods(),
                ),
              ],
            ),
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

  List<CategoryData> _list = [];
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _getCategory();
    _getMallGoods();
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
        itemCount: _list.length,
        itemBuilder: (context, index) {
          return _itemWidget(index);
        },
      ),
    );
  }

  Widget _itemWidget(int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index;
        });
        Provide.value<CategoryState>(context).getBxmallsubdto(_list[index].bxmallsubdto);
        _getMallGoods(categoryId: _list[index].mallcategoryid);
        Provide.value<CategoryState>(context).changeCategoryId(_list[index].mallcategoryid);
      },
      child: Container(
        height: ScreenUtil.getInstance().setHeight(100),
        padding: const EdgeInsets.only(left: 10.0),
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(
          color: _currentIndex == index ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Text(
          _list[index].mallcategoryname,
          style: TextStyle(
              fontSize: ScreenUtil.getInstance().setSp(28)
          ),
        ),
      ),
    );
  }

  void _getCategory() {
    request('getCategory').then((val) {
      var data = json.decode(val.toString());
      CategoryEntity categoryListModel = CategoryEntity.fromJson(data['data']);
      setState(() {
        _list = categoryListModel.data;
      });

      Provide.value<CategoryState>(context).getBxmallsubdto(_list[0].bxmallsubdto);
    });
  }

  void _getMallGoods({ String categoryId }) {
    var formData = {
      'categoryId': categoryId ?? '4',
      'categorySubId': '',
      'page': 1,
    };
    request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val);
      MallGoodsEntity mallGoodsEntity = MallGoodsEntity.fromJson(data);

      Provide.value<CategoryGoodsProvide>(context).getMallGoodsList(mallGoodsEntity.data);
    });
  }
}

class RightContentNav extends StatefulWidget {
  @override
  _RightContentNavState createState() => _RightContentNavState();
}

class _RightContentNavState extends State<RightContentNav> {

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryState>(
      builder: (context, child, categoryState) {
        return Container(
          height: ScreenUtil.getInstance().setHeight(80),
          width: ScreenUtil.getInstance().setWidth(550),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: Colors.black12,
              ),
            ),
          ),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryState.list.length,
            itemBuilder: (context, index) {
              return _singleItem(categoryState.list[index]);
            },
          ),
        );
      },
    );

  }

  Widget _singleItem(item) {
    bool isClick = false;
    isClick = item.mallsubid == Provide.value<CategoryState>(context).mallSubId;
    return InkWell(
      onTap: () {
        Provide.value<CategoryState>(context).changeCategoryChild(item.mallsubid);
        _getMallGoods();
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallsubname,
          style: TextStyle(
            color: isClick ? Colors.pink : Colors.black,
            fontSize: ScreenUtil.getInstance().setSp(28),
          ),
        ),
      ),
    );
  }

  void _getMallGoods() {
    var formData = {
      'categoryId': Provide.value<CategoryState>(context).categoryId,
      'categorySubId': Provide.value<CategoryState>(context).mallSubId,
      'page': Provide.value<CategoryState>(context).page,
    };
    request('getMallGoods', formData: formData).then((val) {
      var data = json.decode(val);
      MallGoodsEntity mallGoodsEntity = MallGoodsEntity.fromJson(data);

      Provide.value<CategoryGoodsProvide>(context).getMallGoodsList(mallGoodsEntity?.data ?? []);
    });
  }
}

class MallGoods extends StatefulWidget {
  @override
  _MallGoodsState createState() => _MallGoodsState();
}

class _MallGoodsState extends State<MallGoods> {

  GlobalKey<RefreshFooterState> _footerKey = GlobalKey();
  var _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsProvide>(
      builder: (context, child, categoryGoodsProvide) {
        try {
          if (Provide.value<CategoryState>(context).page == 1) {
            _scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化${e}');
        }
        return Container(
          width: ScreenUtil.getInstance().setWidth(550),
//      height: ScreenUtil.getInstance().setHeight(970),
          child: EasyRefresh(
            refreshFooter: ClassicsFooter(
              key: _footerKey,
              bgColor: Colors.white,
              textColor: Colors.pink,
              moreInfoColor: Colors.pink,
              showMore: true,
              noMoreText: Provide.value<CategoryState>(context).noLoadMore ?? '',
              moreInfo: '加载中',
              loadReadyText: '上拉加载....',
//              loadedText: '加载完成',
//              loadingText: '加载中',
//              loadText: '上拉加载',
            ),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: categoryGoodsProvide.list.length,
              itemBuilder: (context, index) {
                return _listItemWidget(categoryGoodsProvide.list, index);
              },
            ),
            loadMore: () {
              Provide.value<CategoryState>(context).addPage();
              var formData = {
                'categoryId': Provide.value<CategoryState>(context).categoryId,
                'categorySubId': Provide.value<CategoryState>(context).mallSubId,
                'page': Provide.value<CategoryState>(context).page,
              };
              request('getMallGoods', formData: formData).then((val) {
                var data = json.decode(val);
                MallGoodsEntity mallGoodsEntity = MallGoodsEntity.fromJson(data);
                if (mallGoodsEntity.data == null) {
                  Fluttertoast.showToast(
                    msg: '已全部加载',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    backgroundColor: Colors.pink,
                    textColor: Colors.white,
                    fontSize: 16.0
                  );
                  Provide.value<CategoryState>(context).changeNoLoadMore('没有更多');
                } else {
                  Provide.value<CategoryGoodsProvide>(context).getMoreMallGoodsList(mallGoodsEntity?.data ?? []);
                }
              });
            },
          ),
        );
      },
    );
  }

  Widget _goodsImageWidget(List<MallGoodsData> list, int index) {
    return Container(
      width: ScreenUtil.getInstance().setWidth(200),
      child: Image.network(list[index].image),
    );
  }

  Widget _goodsNameWidget(List<MallGoodsData> list, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil.getInstance().setWidth(350),
      child: Text(
        list[index].goodsname,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(

        ),
      ),
    );
  }

  Widget _goodsPriceWidget(List<MallGoodsData> list, int index) {
    return Container(
      margin: EdgeInsets.only(top: 30),
      width: ScreenUtil.getInstance().setWidth(350),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${list[index].presentprice.toString()}',
            style: TextStyle(
              color: Colors.pink,
              fontSize: ScreenUtil.getInstance().setSp(30),
            ),
          ),
          Text(
            '￥${list[index].oriprice.toString()}',
            style: TextStyle(
              color: Colors.black12,
              fontSize: ScreenUtil.getInstance().setSp(30),
              decoration: TextDecoration.lineThrough,
            ),
          )
        ],
      ),
    );
  }

  Widget _listItemWidget(List<MallGoodsData> list, int index) {
    return InkWell(
      onTap: () {
        Application.router.navigateTo(context, '/detail?id=${list[index].goodsid}');
      },
      child: Container(
        width: ScreenUtil.getInstance().setWidth(550),
        height: ScreenUtil.getInstance().setHeight(200),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.black12,
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            _goodsImageWidget(list, index),
            Column(
              children: <Widget>[
                _goodsNameWidget(list, index),
                _goodsPriceWidget(list, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

