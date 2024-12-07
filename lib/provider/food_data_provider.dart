import 'package:ecologital_pvt_limited_food_ordering_app/models/data_box.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/category.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/item.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/modifier.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:ecologital_pvt_limited_food_ordering_app/models/data.dart';

class FoodDataProvider with ChangeNotifier {
  Data? data;
  List<DataBox> dataBoxList = [];
  List<Item> itemList = [];
  List<Modifier> modifierGroupList = [];
  Future<void> loadFoodData() async {
    try {
      // Load JSON string from the assets
      final String jsonString =
          await rootBundle.loadString('assets/assignment-dataset.json');

      final dynamic jsonData = jsonDecode(jsonString);

      // Convert each JSON object into a data instance
      data = Data.fromJson(jsonData);
      dataBoxList.addAll(data?.result.menu
              .map((menu) => DataBox(
                  menuTitle: menu.title ?? '__', menuId: menu.menuId ?? '__'))
              .toList() ??
          []);
      notifyListeners();
    } catch (e, stackTrace) {
      if (!kReleaseMode) {
        print('error: $e');
        print(stackTrace);
      }
    }
  }

  void getCategoriesForMenu(String menuId, int index) {
    // Find categories for the provided menuId
    final List<MenuCategory> categoriesForMenu = data?.result.category
            .where((category) => category.menuId == menuId)
            .toList() ??
        [];
    // Add the category titles to the specified DataBox
    dataBoxList[index].categoryTitle =
        categoriesForMenu.map((category) => category.title).join(', ');
    dataBoxList[index].menuCategoryId =
        categoriesForMenu.map((category) => category.menuCategoryId).join(', ');
    notifyListeners();
  }

  void getItems(String categoryId) {
    if (itemList.isNotEmpty) {
      itemList = [];
    }
    itemList = data?.result.item
            .where((item) => item.categoryId == categoryId)
            .toList() ??
        [];

    notifyListeners();
  }

  void getModifierGroups(String modifierGroupId) {
    if (modifierGroupList.isNotEmpty) {
      modifierGroupList = [];
    }
    modifierGroupList = data?.result.modifierGroupRules
            .where((modifier) => modifier.modifierGroupId == modifierGroupId)
            .toList() ??
        [];

    notifyListeners();
  }
}
