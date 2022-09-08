import 'package:grpc/grpc.dart';
import 'dart:io';
import 'dart:math';
import 'package:server_side_course/server_side_course.dart';

class Client {
  groceriesServiceClient? stub;
  ClientChannel? channel;
  var response;
  bool executionInProgress = true;

  int _randomId() => Random(1000).nextInt(9999);

  Future<Category> _findCategoryByName(String name) async {
    var category = Category()..name = name;
    category = await stub!.getCategory(category);
    return category;
  }

  Future<Item> _findItemByName(String name) async {
    var item = Item()..name = name;
    item = await stub!.getItem(item);
    return item;
  }

  Future<void> main() async {
    channel = ClientChannel('localhost',
        port: 50000,
        options:
            const ChannelOptions(credentials: ChannelCredentials.insecure()));

    stub = groceriesServiceClient(channel!,
        options: CallOptions(timeout: Duration(seconds: 30)));

    while (executionInProgress) {
      try {
        print("__________________________________________________");
        print("|--Welcome to our shop                           |");
        print("|--What do you want to do?                       |");
        print("|1: View All Products                            |");
        print("|2: Add a new Product                            |");
        print("|3: Edit a Product                               |");
        print("|4: Get Product                                  |");
        print("|5: Delete Product                               |");
        print("|6: View all Categories                          |");
        print("|7: Add a new Category                           |");
        print("|8: Edit a Category                              |");
        print("|9: Get Category                                 |");
        print("|10: Delete Category                             |");
        print("|11: Get all products from a category            |");
        print("__________________________________________________");
        var sOption = int.parse(stdin.readLineSync()!);
        switch (sOption) {
          case 1:
            response = await stub!.getAllItems(Empty());
            print(' --- Store products --- ');
            response.items.forEach((item) {
              print(
                  '${item.name} (id: ${item.id} | categoryId: ${item.categoryId})');
            });
            break;
          case 2:
            print('Enter product name');
            var name = stdin.readLineSync()!;
            var item = await _findItemByName(name);
            if (item.id != 0) {
              print(
                  'product already exists: name ${item.name} | id: ${item.id} ');
            } else {
              print('Enter product\'s category name');
              var categoryName = stdin.readLineSync()!;
              var category = await _findCategoryByName(categoryName);
              if (category.id == 0) {
                print(
                    'category $categoryName does not exists, try creating it first');
              } else {
                item = Item()
                  ..name = name
                  ..id = _randomId()
                  ..categoryID = category.id;
                response = await stub!.createItem(item);
                print(
                    'product created name: ${response.name} id: ${response.id} category id: ${response.categoryId}');
              }
            }
            break;
          case 3:
            print('Enter your produt\'s name: ');
            var name = stdin.readLineSync()!;
            var item = await _findItemByName(name);
            if (item.id != 0) {
              print('Enter new product name');
              name = stdin.readLineSync()!;
              response = await stub!.editItem(
                  Item(id: item.id, name: name, categoryID: item.categoryID));
              if (response.name == name) {
                print(
                    'product updated name: ${response.name} id: ${response.id}');
              } else {
                print('product update failed');
              }
            } else {
              print('product $name not found, try creating it!');
            }
            break;
          case 4:
            print('Enter your produt\'s name: ');
            var name = stdin.readLineSync()!;
            var item = await _findItemByName(name);
            if (item.id != 0) {
              print(
                  'product found name: ${item.name} id: ${item.id} category id: ${item.categoryID}');
            } else {
              print('no product matches the name $name');
            }
            break;
          case 5:
            print('Enter your produt\'s name: ');
            var name = stdin.readLineSync()!;
            var item = await _findItemByName(name);
            if (item.id != 0) {
              await stub!.deleteItem(item);
              print('item deleted');
            } else {
              print('product $name does not exist ');
            }

            break;
          case 6:
            response = await stub!.getAllCategories(Empty());
            print('------- Store Category List -------');
            response.categories.forEach((category) {
              print('name: ${category.name} id: ${category.id}');
            });
            break;
          case 7:
            print("Enter your category's name: ");
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              print(
                  'we have this category in our databse: ${category.name} id: ${category.id}');
            } else {
              category = Category()
                ..id = Random(1000).nextInt(9999)
                ..name = name;
              response = await stub!.createCategory(category);
              print(
                  'Category Created! name: ${category.name} id: ${category.id}');
            }
            break;

          case 8:
            print("------- enter category name: -------");
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              print("Enter new name: ");
              name = stdin.readLineSync()!;
              response = await stub!
                  .editCategory(Category(id: category.id, name: name));
              if (response.name == name) {
                print(
                    "Category is Updated | name = $response.name | id = $response.id");
              } else {
                print("failed");
              }
            } else {
              print("We can't find your category. create it first");
            }
            break;
          case 9:
            print("------- enter category name: --------");
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              print(
                  'we found your category: ${category.name} id: ${category.id}');
            } else {
              print('we don\'t have your category in database');
            }
            break;
          case 10:
            print("------- enter category name: --------");
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              await stub!.deleteCategory(category);
              print("category deleted");
            } else {
              print('we don\'t have your category in database');
            }
            break;
          case 11:
            print('Enter category name');
            var name = stdin.readLineSync()!;
            var category = await _findCategoryByName(name);
            if (category.id != 0) {
              var _result = await stub!.getItemsSortedByCategory(category);
              print('--- all products of the $name category --- ');

              _result.items.forEach((item) {
                print('${item.name}');
              });
            } else {
              print('category $name not found');
            }

            break;
          default:
            print("Wrong option");
            break;
        }
      } catch (e) {
        print(e);
      }

      print('Do you want to close the application? (y/n)');
      var fresult = stdin.readLineSync() ?? 'y';
      executionInProgress = fresult.toLowerCase() != 'y';
    }
    await channel!.shutdown();
  }
}

void main(List<String> args) {
  var client = Client();
  client.main();
}
