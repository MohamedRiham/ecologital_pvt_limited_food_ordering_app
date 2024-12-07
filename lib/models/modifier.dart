class Modifier {
  String? id;
  String? modifierGroupId;
  String? title;
  String? storeId;
  String? displayType;

  Modifier(
      {this.id,
      this.modifierGroupId,
      this.title,
      this.storeId,
      this.displayType});

  Modifier.fromJson(dynamic json) {
    id = json['ID'];
    modifierGroupId = json['ModifierGroupID'];
    title = json['Title']['en'];
    storeId = json['StoreID'];
    displayType = json['DisplayType'];
  }
}
