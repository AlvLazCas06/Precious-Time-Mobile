import 'package:precious_time_mobile/core/models/category_list.dart';

abstract class CategoryInterface {
  Future<List<Category>> getCategories();
}