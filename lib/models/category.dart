class MenuCategory {
  String? id;
  String? menuCategoryId;
  String? menuId;
  String? storeId;
  String? title;

  MenuCategory.fromJson(dynamic json) {
    id = json['ID'];
    menuId = json['MenuID'];
    menuCategoryId = json['MenuCategoryID'];
    storeId = json['StoreID'];
    title = json['Title']['en'];
  }
}
