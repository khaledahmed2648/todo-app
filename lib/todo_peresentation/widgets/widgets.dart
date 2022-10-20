import 'dart:ui';

import 'package:flutter/material.dart';

import '../../todo_basic_logic/cubit/todo_cubit.dart';

Widget buildTaskItem(Map tasks,int currentItem,context){
  var cubit=TodoCubit.get(context);
  return Padding(

  padding: const EdgeInsets.symmetric(horizontal: 8.0),
  child:   Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Colors.amberAccent,
            child: Text(
              '${tasks['time']}',
              style: Theme.of(context).textTheme.bodyText1!.copyWith(fontWeight:FontWeight.bold)

            ),
            radius: 40,

          ),
          SizedBox(width: 8,),
          Expanded(
            child: Column(
              crossAxisAlignment:CrossAxisAlignment.start,
              children: [
                Text(
                  '${tasks['title']}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,

                  ),
                  maxLines: 2,
                ),
                SizedBox(height: 5,),
                Text(
                  '${tasks['date']}',

                ),

              ],
            ),

    ),
        SizedBox(width: 10,),
          if(currentItem==0)
            IconButton(
              color: Colors.brown,
              icon:Icon(Icons.archive) ,
              onPressed: (){
                cubit.database.rawUpdate('UPDATE tasks SET status=? WHERE id=?',["archived","${tasks['id']}"])
                    .then((value){
                      cubit.getDataFromDatabase();
                })
                    .catchError((error){
                      print(error.toString());

                });
              },
            ),
          if(currentItem==0)
            SizedBox(
              width: 5,
            ),
          if(currentItem==0)
            IconButton(
              icon:Icon(Icons.done) ,
              onPressed: (){
                cubit.database.rawUpdate('UPDATE tasks SET status=? WHERE id=?',["done","${tasks['id']}"])
                    .then((value){
                  cubit.getDataFromDatabase();
                })
                    .catchError((error){
                  print(error.toString());

                });
              },
            ),
          if(currentItem==1)
            IconButton(
              icon:Icon(Icons.restore) ,
              onPressed: (){
                cubit.database.rawUpdate('UPDATE tasks SET status=? WHERE id=?',["new","${tasks['id']}"])
                    .then((value){
                  cubit.getDataFromDatabase();
                })
                    .catchError((error){
                  print(error.toString());

                });
              },
            ),
          if(currentItem==1)
            SizedBox(
              width: 5,
            ),
          if(currentItem==1)
            IconButton(
              icon:Icon(Icons.done) ,
              onPressed: (){
                cubit.database.rawUpdate('UPDATE tasks SET status=? WHERE id=?',["done","${tasks['id']}"])
                    .then((value){
                  cubit.getDataFromDatabase();
                })
                    .catchError((error){
                  print(error.toString());

                });
              },
            ),
          if(currentItem==2)
            IconButton(
              icon:Icon(Icons.restore) ,
              onPressed: (){
                cubit.database.rawUpdate('UPDATE tasks SET status=? WHERE id=?',["new","${tasks['id']}"])
                    .then((value){
                  cubit.getDataFromDatabase();
                })
                    .catchError((error){
                  print(error.toString());

                });
              },
            ),
          if(currentItem==2)
            SizedBox(
              width: 5,
            ),
          if(currentItem==2)
            IconButton(
              icon:Icon(Icons.delete) ,
              onPressed: (){
                cubit.database.rawDelete('DELETE FROM tasks WHERE id=?',['${tasks['id']}'])
                    .then((value) {
                      cubit.getDataFromDatabase();
                })
                    .catchError((error){
                  print(error.toString());
                });
              },
            ),


        ],
    ),
    ),
  ),
);}
