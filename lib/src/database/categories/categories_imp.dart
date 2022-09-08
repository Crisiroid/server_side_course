import 'package:server_side_course/server_side_course.dart';

class CategoriesServices implements CtgServices {
  @override
  Category? createCategory(Category category) {
    categories.add({'id': category.id, 'name': category.name});
    return category;
  }

  @override
  Empty? deleteCategory(Category category) {
    categories.removeWhere((element) => element['id'] == category.id);
    return Empty();
  }

  @override
  Category? editCategory(Category category) {
    try {
      var categoryIndex =
          categories.indexWhere((element) => element['id'] == category.id);
      categories[categoryIndex]['name'] = category.name;
    } catch (e) {
      print("ERROR :: $e");
    }
    return category;
  }

  @override
  List<Category>? getCategories() {
    return categories.map((category) {
      return helper.generateCategoryFromMaps(category);
    }).toList();
  }

  @override
  Category? getCategoryById(int id) {
    var category = Category();
    var result = categories.where((element) => element['id'] == id).toList();
    if (result.isNotEmpty) {
      category = helper.generateCategoryFromMaps(result.first);
    }
    return category;
  }

  @override
  Category? getCategoryByName(String name) {
    var category = Category();
    var result =
        categories.where((element) => element['name'] == name).toList();
    if (result.isNotEmpty) {
      category = helper.generateCategoryFromMaps(result.first);
    }
    return category;
  }
}
