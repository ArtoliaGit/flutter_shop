import 'package:flutter_shop/model/category_entity.dart';
import 'package:flutter_shop/model/details_entity.dart';
import 'package:flutter_shop/model/mall_goods_entity.dart';

class EntityFactory {
  static T generateOBJ<T>(json) {
    if (1 == 0) {
      return null;
    } else if (T.toString() == "CategoryEntity") {
      return CategoryEntity.fromJson(json) as T;
    } else if (T.toString() == "DetailsEntity") {
      return DetailsEntity.fromJson(json) as T;
    } else if (T.toString() == "MallGoodsEntity") {
      return MallGoodsEntity.fromJson(json) as T;
    } else {
      return null;
    }
  }
}