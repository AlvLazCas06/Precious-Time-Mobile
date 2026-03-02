part of 'project_list_bloc.dart';

@immutable
sealed class ProjectListEvent {}

final class ProjectListFetchAllEvent extends ProjectListEvent {}
