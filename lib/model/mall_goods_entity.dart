class MallGoodsEntity {
	String code;
	List<MallGoodsData> data;
	String message;

	MallGoodsEntity({this.code, this.data, this.message});

	MallGoodsEntity.fromJson(Map<String, dynamic> json) {
		code = json['code'];
		if (json['data'] != null) {
			data = new List<MallGoodsData>();
			(json['data'] as List).forEach((v) { data.add(new MallGoodsData.fromJson(v)); });
		}
		message = json['message'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['code'] = this.code;
		if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
		data['message'] = this.message;
		return data;
	}
}

class MallGoodsData {
	String image;
	double oriprice;
	double presentprice;
	String goodsid;
	String goodsname;

	MallGoodsData({this.image, this.oriprice, this.presentprice, this.goodsid, this.goodsname});

	MallGoodsData.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		oriprice = json['oriPrice'];
		presentprice = json['presentPrice'];
		goodsid = json['goodsId'];
		goodsname = json['goodsName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		data['oriPrice'] = this.oriprice;
		data['presentPrice'] = this.presentprice;
		data['goodsId'] = this.goodsid;
		data['goodsName'] = this.goodsname;
		return data;
	}
}
