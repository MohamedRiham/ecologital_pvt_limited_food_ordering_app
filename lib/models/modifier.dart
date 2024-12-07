class Modifier {
  String? id;
  String? modifierGroupId;
  String? title;
  String? storeId;
  String? displayType;
bool? isChecked = false;
  Modifier.fromJson(dynamic json) {
    id = json['ID'];
    modifierGroupId = json['ModifierGroupID'];
    title = json['Title']['en'];
    storeId = json['StoreID'];
    displayType = json['DisplayType'];
  }
}
