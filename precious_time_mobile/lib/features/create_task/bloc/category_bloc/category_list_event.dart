part of 'category_list_bloc.dart';

@immutable
sealed class CategoryListEvent {}

final class CategoryListFetchAllEvent extends CategoryListEvent {}