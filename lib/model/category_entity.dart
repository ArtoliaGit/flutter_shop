class CategoryEntity {
	List<CategoryData> data;

	CategoryEntity({this.data});

	CategoryEntity.fromJson(List<dynamic> json) {
		if (json != null) {
			data = new List<CategoryData>();
			json.forEach((v) { data.add(new CategoryData.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class CategoryData {
	String image;
	List<CategoryDataBxmallsubdto> bxmallsubdto;
	dynamic comments;
	String mallcategoryid;
	String mallcategoryname;

	CategoryData({this.image, this.bxmallsubdto, this.comments, this.mallcategoryid, this.mallcategoryname});

	CategoryData.fromJson(Map<String, dynamic> json) {
		image = json['image'];
		if (json['bxMallSubDto'] != null) {
			bxmallsubdto = new List<CategoryDataBxmallsubdto>();
			(json['bxMallSubDto'] as List).forEach((v) { bxmallsubdto.add(new CategoryDataBxmallsubdto.fromJson(v)); });
		}
		comments = json['comments'];
		mallcategoryid = json['mallCategoryId'];
		mallcategoryname = json['mallCategoryName'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['image'] = this.image;
		if (this.bxmallsubdto != null) {
      data['bxMallSubDto'] = this.bxmallsubdto.map((v) => v.toJson()).toList();
    }
		data['comments'] = this.comments;
		data['mallCategoryId'] = this.mallcategoryid;
		data['mallCategoryName'] = this.mallcategoryname;
		return data;
	}
}

class CategoryDataBxmallsubdto {
	String mallsubname;
	String comments;
	String mallcategoryid;
	String mallsubid;

	CategoryDataBxmallsubdto({this.mallsubname, this.comments, this.mallcategoryid, this.mallsubid});

	CategoryDataBxmallsubdto.fromJson(Map<String, dynamic> json) {
		mallsubname = json['mallSubName'];
		comments = json['comments'];
		mallcategoryid = json['mallCategoryId'];
		mallsubid = json['mallSubId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['mallSubName'] = this.mallsubname;
		data['comments'] = this.comments;
		data['mallCategoryId'] = this.mallcategoryid;
		data['mallSubId'] = this.mallsubid;
		return data;
	}
}
