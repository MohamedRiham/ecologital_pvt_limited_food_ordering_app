import 'package:ecologital_pvt_limited_food_ordering_app/models/menu.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/category.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/item.dart';
import 'package:ecologital_pvt_limited_food_ordering_app/models/modifier.dart';

class Result {
  List<Menu> menu;
  List<MenuCategory> category;
  List<Item> item;
  List<Modifier> modifierGroupRules;
  Result(
      {required this.menu,
      required this.category,
      required this.item,
      required this.modifierGroupRules});

  factory Result.fromJson(dynamic json) {
    return Result(
        menu: (json['Menu'] as List?)
                ?.map((menuJson) => Menu.fromJson(menuJson))
                .toList() ??
            [],
        category: (json['Categories'] as List?)
                ?.map((categories) => MenuCategory.fromJson(categories))
                .toList() ??
            [],
        item: (json['Items'] as List?)
                ?.map((item) => Item.fromJson(item))
                .toList() ??
            [],
        modifierGroupRules: (json['ModifierGroups'] as List?)
                ?.map((modifierGroupRules) =>
                    Modifier.fromJson(modifierGroupRules))
                .toList() ??
            []);
  }
}
