class DataBox {
  String menuTitle;
  String menuId;
  String? categoryTitle;
  String? menuCategoryId;
  DataBox(
      {required this.menuTitle,
      required this.menuId,
      this.categoryTitle,
      this.menuCategoryId});
}
