class Menu {
  String? id;
  String? menuId;
  String? verticalId;
  String? storeId;
  String? title;

  Menu.fromJson(dynamic json) {
    id = json['ID'];
    menuId = json['MenuID'];
    verticalId = json['VerticalID'];
    storeId = json['StoreID'];
    title = json['Title']['en'];
  }
}
