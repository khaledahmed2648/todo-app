import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);
  List<Map> Newtasks=[];
  List<Map> DoneTasks=[];
  List<Map> ArchivedTasks=[];

  int currentItem = 0;

  void chaneCurrentItem(index) {
    currentItem = index;
    emit(changeCurrentItemState());
  }

  List<String> titles = [
    'Tesks',
    'Archived',
    'Done',
  ];
  late Database database;

  void createDatabase() {
    openDatabase(
        'todo.db',
        version: 1,
        onCreate: (database, version) {
          database
              .execute(
              'CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT,time TEXT,status TEXT)')
              .then((value) {
            emit(CreateDatabaseSuccessState());

          })
              .catchError((error) {
                print(error.toString());
            emit(CreateDatabaseErrorState());
          });
        },
        onOpen: (database) {
       }
    ).then((value) {
      database = value;
      getDataFromDatabase();
      print(Newtasks);

    }).catchError((error) {
      print(error.toString());

    });
  }

  Future insertIntoDatabase({
    required String title,
    required String date,
    required String time,
  }) async {
    database.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks (title,date,time,status)VALUES("$title","$date","$time","new")')
          .then((value) {
        emit(InsertDatabaseSuccessState());
        getDataFromDatabase();

      })
          .catchError((error) {
        emit(InsertDatabaseErrorState());

        print(error.toString());

      });
    });
  }


  void getDataFromDatabase() {
    Newtasks=[];
    DoneTasks=[];
    ArchivedTasks=[];
    database.rawQuery('SELECT * FROM tasks')
        .then((value) {
          print(value);
      value.forEach((element) {
        if (element['status'] == 'new')
          Newtasks.add(element);
        if (element['status'] == 'archived')
          ArchivedTasks.add(element);
        if (element['status'] == 'done')
          DoneTasks.add(element);
      });
      emit(getDatabaseSuccessState());

    })
        .catchError((error) {
          print(error.toString());
      emit(getDatabaseErrorState());
    });
  }

  bool isButtomSheetShown = false;
  IconData floatingIcon = Icons.edit;

  void changebottomSheet({
    required bool isButtomShown,
    required IconData Icon

  }) {
    isButtomSheetShown = isButtomShown;
    floatingIcon = Icon;
    emit(changeBottomSheetState());
  }


}