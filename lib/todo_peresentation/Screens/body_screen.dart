import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../todo_basic_logic/cubit/todo_cubit.dart';
import '../widgets/widgets.dart';

class BodyScreen extends StatelessWidget {

  const BodyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = TodoCubit.get(context);
    return BlocBuilder<TodoCubit,TodoState>(
      builder: (context,state){
        if (cubit.currentItem == 0)
          return ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskItem(
                    cubit.Newtasks[index], cubit.currentItem, context);
              },
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(width: double.infinity, height: 1,),
                  ),
              itemCount: cubit.Newtasks.length


          );
        if (cubit.currentItem == 1)
          return ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskItem(
                    cubit.ArchivedTasks[index],cubit.currentItem,
                    context);
              },
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(width: double.infinity, height: 1,),
                  ),
              itemCount: cubit.ArchivedTasks.length


          );
        else
          return ListView.separated(
              itemBuilder: (context, index) {
                return buildTaskItem(
                    cubit.DoneTasks[index], cubit.currentItem,
                    context);
              },
              separatorBuilder: (context, index) =>
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Container(width: double.infinity, height: 1,),
                  ),
              itemCount: cubit.DoneTasks.length


          );


      },

    );
  }

}