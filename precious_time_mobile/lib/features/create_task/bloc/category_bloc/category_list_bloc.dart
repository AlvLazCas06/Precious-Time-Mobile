import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:precious_time_mobile/core/models/category_list.dart';
import 'package:precious_time_mobile/core/service/category_service.dart';

part 'category_list_event.dart';
part 'category_list_state.dart';

class CategoryListBloc extends Bloc<CategoryListEvent, CategoryListState> {
  CategoryListBloc(CategoryService categoryService) : super(CategoryListInitial()) {
    on<CategoryListEvent>((event, emit) async {
      emit(CategoryListLoading());
      try {
        var categories = await categoryService.getCategories();
        emit(CategoryListSuccess(categories: categories));
      } catch (e) {
        emit(CategoryListError(message: e.toString()));
      }
    });
  }
}
