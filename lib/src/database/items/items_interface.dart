import 'package:server_side_course/server_side_course.dart';

abstract class ItmsServices {
  factory ItmsServices() => ItemsServices();
  Item? getItemByName(String name) {}
  Item? getItemById(int id) {}
  Item? createItem(Item item) {}
  Item? editItem(Item item) {}
  Empty? deleteItem(Item item) {}
  List<Item>? getItems() {}
  List<Item>? getItemsByCategory(int categoryId) {}
}

final itemsServices = ItmsServices();
