import 'package:server_side_course/server_side_course.dart';

class helperMethods {
  Category generateCategoryFromMaps(Map category) {
    var _idTag = 1;
    var _nameTag = 2;
    int _id = category['id'];
    String _name = category['name'];
    return Category.fromJson('{"$_idTag": $_id, "$_nameTag": "$_name"}');
  }

  Item generateItemFromMaps(Map item) {
    var _idTag = 1;
    var _nameTag = 2;
    var _categoryIdTag = 3;
    int _id = item['id'];
    String _name = item['name'];
    int _categoryID = item['categoryID'];
    return Item.fromJson(
        '{"$_idTag": $_id, "$_nameTag": "$_name", "$_categoryIdTag": $_categoryID}');
  }
}

final helper = helperMethods();
