class MenuCategory {
  String? id;
  String? menuCategoryId;
  String? menuId;
  String? storeId;
  String? title;
  MenuCategory({this.id, this.menuId, this.menuCategoryId, this.storeId});

  MenuCategory.fromJson(dynamic json) {
    id = json['ID'];
    menuId = json['MenuID'];
    menuCategoryId = json['MenuCategoryID'];
    storeId = json['StoreID'];
    title = json['Title']['en'];
  }
}
