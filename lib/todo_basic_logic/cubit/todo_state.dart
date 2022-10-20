part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class changeCurrentItemState extends TodoState{}
class CreateDatabaseSuccessState extends TodoState{}
class InsertDatabaseSuccessState extends TodoState{}
class CreateDatabaseErrorState extends TodoState{}
class InsertDatabaseErrorState extends TodoState{}
class getDatabaseSuccessState extends TodoState{}
class getDatabaseErrorState extends TodoState{}
class changeBottomSheetState extends TodoState{}


