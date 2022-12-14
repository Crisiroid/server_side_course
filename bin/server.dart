import 'package:grpc/grpc.dart';
import 'package:server_side_course/server_side_course.dart';

class groceriesService extends groceriesServiceBase {
  @override
  Future<Category> createCategory(ServiceCall call, Category category) async =>
      categoriesServices.createCategory(category)!;

  @override
  Future<Item> createItem(ServiceCall call, Item request) async =>
      itemsServices.createItem(request)!;

  @override
  Future<Empty> deleteCategory(ServiceCall call, Category request) async =>
      categoriesServices.deleteCategory(request)!;

  @override
  Future<Empty> deleteItem(ServiceCall call, Item request) async =>
      itemsServices.deleteItem(request)!;

  @override
  Future<Category> editCategory(ServiceCall call, Category request) async =>
      categoriesServices.editCategory(request)!;
  @override
  Future<Item> editItem(ServiceCall call, Item request) async =>
      itemsServices.editItem(request)!;

  @override
  Future<Categories> getAllCategories(ServiceCall call, Empty request) async =>
      Categories()..categories.addAll(categoriesServices.getCategories()!);

  @override
  Future<Items> getAllItems(ServiceCall call, Empty request) async =>
      Items()..items.addAll(itemsServices.getItems()!);

  @override
  Future<Category> getCategory(ServiceCall call, Category request) async =>
      categoriesServices.getCategoryByName(request.name)!;

  @override
  Future<Item> getItem(ServiceCall call, Item request) async =>
      itemsServices.getItemById(request.id)!;
  @override
  Future<AllItemsInCategory> getItemsSortedByCategory(
          ServiceCall call, Category request) async =>
      AllItemsInCategory(
          items: itemsServices.getItemsByCategory(request.id)!,
          categoryID: request.id);
}

Future<void> main() async {
  final server = Server([groceriesService()], const <Interceptor>[],
      CodecRegistry(codecs: const [GzipCodec(), IdentityCodec()]));
  await server.serve(port: 50000);
  print('server is working on port ${server.port}');
}
