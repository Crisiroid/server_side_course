import 'package:server_side_course/server_side_course.dart';

class ItemsServices implements ItmsServices {
  @override
  //Add an Item to list => Data.dart Item list
  Item? createItem(Item item) {
    items
        .add({'id': item.id, 'name': item.name, 'categoryID': item.categoryID});
    return item;
  }

  //Remo an Item from list => Data.dart Item list
  @override
  Empty? deleteItem(Item item) {
    items.removeWhere((element) => element['id'] == item.id);
    return Empty();
  }

  //First we create try cath block.then we find item's index by its id. and then we change its name.
  @override
  Item? editItem(Item item) {
    try {
      var itemIndex = items.indexWhere((element) => element['id'] == item.id);
      categories[itemIndex]['name'] = item.name;
    } catch (e) {
      print('ERROR:: $e');
    }
    return item;
  }

  //First we get Item's id and search in our list using helper class
  @override
  Item? getItemById(int id) {
    var item = Item();
    var result = items.where((element) => element['id'] == id).toList();
    if (result.isNotEmpty) {
      item = helper.generateItemFromMaps(result.first);
    }
    return item;
  }

  //First we get Item's name and search in our list using helper class
  @override
  Item? getItemByName(String name) {
    var item = Item();
    var result = items.where((element) => element['name'] == name).toList();
    if (result.isNotEmpty) {
      item = helper.generateItemFromMaps(result.first);
    }
    return item;
  }

  //We open Item's list and return everything in order
  @override
  List<Item> getItems() {
    return items.map((item) {
      return helper.generateItemFromMaps(item);
    }).toList();
  }

  //We create a list, we find the Items based on their category ID and then we return the result
  @override
  List<Item>? getItemsByCategory(int categoryId) {
    var result = <Item>[];
    var jsonList =
        items.where((element) => element['categoryId'] == categoryId).toList();
    result = jsonList.map((item) => helper.generateItemFromMaps(item)).toList();
    return result;
  }
}
