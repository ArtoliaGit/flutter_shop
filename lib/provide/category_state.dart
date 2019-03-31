import 'package:flutter/material.dart';
import '../model/category_entity.dart';

class CategoryState with ChangeNotifier {

  List<CategoryDataBxmallsubdto> list = [];
  String mallSubId = '';
  String categoryId = '4';
  int page = 1;
  String noLoadMore = '';

  getBxmallsubdto(List<CategoryDataBxmallsubdto> list) {
    CategoryDataBxmallsubdto bxmallsubdto = CategoryDataBxmallsubdto();
    bxmallsubdto.mallsubid = '';
    bxmallsubdto.mallcategoryid = '';
    bxmallsubdto.comments = 'null';
    bxmallsubdto.mallsubname = '全部';
    this.mallSubId = '';
    this.list = [];
    this.list.add(bxmallsubdto);
    this.list.addAll(list);
    notifyListeners();
  }

  changeCategoryChild(String index) {
    this.mallSubId = index;
    this.page = 1;
    this.noLoadMore = '';
    notifyListeners();
  }

  changeCategoryId(String index) {
    this.categoryId = index;
    this.page = 1;
    this.noLoadMore = '';
    notifyListeners();
  }

  addPage() {
    page++;
  }

  changeNoLoadMore(String text) {
    this.noLoadMore = text;
    notifyListeners();
  }
}