part of 'category_list_bloc.dart';

@immutable
sealed class CategoryListState {}

final class CategoryListInitial extends CategoryListState {}

final class CategoryListLoading extends CategoryListState {}

final class CategoryListSuccess extends CategoryListState {
  CategoryListSuccess({
    required this.categories
  });
  final List<Category> categories;
}

final class CategoryListError extends CategoryListState {
  CategoryListError({
    required this.message
  });
  final String message;
}
