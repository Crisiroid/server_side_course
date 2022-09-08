import 'package:server_side_course/server_side_course.dart';

abstract class CtgServices {
  factory CtgServices() => CategoriesServices();

  Category? getCategoryByName(String name) {}
  Category? getCategoryById(int id) {}
  Category? createCategory(Category category) {}
  Empty? deleteCategory(Category category) {}
  Category? editCategory(Category category) {}
  List<Category>? getCategories() {}
}

final categoriesServices = CtgServices();
