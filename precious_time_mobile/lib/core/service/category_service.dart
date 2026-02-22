import 'package:precious_time_mobile/core/interface/category_interface.dart';
import 'package:precious_time_mobile/core/models/category_list.dart';
import 'package:precious_time_mobile/core/service/api_client.dart';
import 'package:precious_time_mobile/core/service/token_manager.dart';

class CategoryService implements CategoryInterface {
  final ApiClient _apiClient = ApiClient(TokenManager());
  final String endpoint = '/api/v1/categories';

  @override
  Future<List<Category>> getCategories() async {
    try {
      var response = await _apiClient.get(endpoint);
      if (response.statusCode >= 200 || response.statusCode < 300) {
        var categories = CategoryListResponse.fromJson(
          response.headers,
        ).content;
        return categories;
      }
      return [];
    } catch (e) {
      throw Exception('Error al cargar las categorias');
    }
  }
}
