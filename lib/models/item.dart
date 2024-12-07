class Item {
  String? id;
  String? menuItemId;
  String? storeId;
  String? title;
  String? description;
  String? imageUrl;
  String? categoryId;
  int? price;
  bool? isDealProduct;
  String? modifierGroupId;
int? totalReviews;

  Item.fromJson(dynamic json) {
    id = json['ID'];
    menuItemId = json['MenuItemID'];
    storeId = json['StoreID'];
    title = json['Title']['en'];
    description = json['Description']['en'];
    imageUrl = json['ImageURL'];
    categoryId = json['CategoryIDs'] != null ? json['CategoryIDs'][0] : null;
    price = json['PriceInfo']['Price']['DeliveryPrice'];
    isDealProduct = json['MetaData']['IsDealProduct'];
    modifierGroupId = json['ModifierGroupRules']['IDs'] != null
        ? json['ModifierGroupRules']['IDs'][0]
        : null;
    totalReviews = json['TotalReviews'];
  }
}
