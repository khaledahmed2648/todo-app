
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../todo_basic_logic/cubit/todo_cubit.dart';
import 'body_screen.dart';

class HomeScreen extends StatelessWidget {
  var scaffoldkey=GlobalKey<ScaffoldState>();
  var formKey =GlobalKey<FormState>();
  var titleController=TextEditingController();
  var dateController=TextEditingController();
  var timeController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQueryData=MediaQuery.of(context);
    return BlocProvider(

        create: (BuildContext context)=>TodoCubit()..createDatabase(),
        child: BlocBuilder<TodoCubit,TodoState>(
        builder: (BuildContext context, state) {
          var cubit=TodoCubit.get(context);

          return Scaffold(
            resizeToAvoidBottomInset : false,
            key: scaffoldkey,
            appBar: AppBar(
              backgroundColor: Colors.deepOrangeAccent,
              title: Text(
                  '${cubit.titles[cubit.currentItem]}'
              ),
            ),
            body: BodyScreen(),
            floatingActionButton: FloatingActionButton(
              onPressed: (){
                if(cubit.isButtomSheetShown==false){

                  scaffoldkey.currentState!.showBottomSheet((context) {

                    return SingleChildScrollView(
                      child: Container(
                        width: double.infinity,
                          height: 500,
                          color: Colors.white,
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller:titleController,
                                  onTap:(){

                                  },
                                  validator:(value){
                                    if(value!.isEmpty){
                                      return 'your task must not be empty';
                                    }
                                  } ,
                                  decoration: InputDecoration(

                                      border: OutlineInputBorder(),
                                      labelText: 'Your task'
                                  ),

                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: TextFormField(
                                    controller:timeController,
                                    onTap:(){
                                      showTimePicker(context: context,initialTime: TimeOfDay.now())
                                          .then((value) {
                                        timeController.text=value!.format(context).toString();
                                      });
                                    },
                                    validator:(value){
                                      if(value!.isEmpty){
                                        return 'time must not be empty';
                                      }
                                    } ,
                                    decoration: InputDecoration(

                                        border: OutlineInputBorder(),
                                        labelText: 'Excisting time'
                                    ),

                                  ),
                                ),
                                TextFormField(
                                  controller:dateController,
                                  onTap:(){
                                    showDatePicker(firstDate:DateTime.now(),initialDate: DateTime.now(),lastDate: DateTime.parse('2022-12-12'),context: context)
                                        .then((value){
                                          dateController.text=value!.toString();
                                    });

                                  },
                                  validator:(value){
                                    if(value!.isEmpty){
                                      return 'date must not be empty';
                                    }
                                  } ,
                                  decoration: InputDecoration(

                                      border: OutlineInputBorder(),
                                      labelText: 'date'
                                  ),

                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );}).closed.then((value) {
                    cubit.changebottomSheet(isButtomShown: false, Icon: Icons.edit);
                  });
                  cubit.changebottomSheet(isButtomShown: true,Icon: Icons.add);
                }else{
                  cubit.changebottomSheet(isButtomShown: false,Icon:Icons.edit);
                if(formKey.currentState!.validate()) {
                  cubit.insertIntoDatabase(title: titleController.text,
                      date: dateController.text,
                      time: timeController.text);
                  titleController.text = '';
                  timeController.text = '';
                  dateController.text = '';
                  Navigator.pop(context);
                }
                }
              },
              child: Icon(
                cubit.floatingIcon,
              ),
              backgroundColor: Colors.deepOrange,
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex:cubit.currentItem,
              selectedItemColor: Colors.orange,
              onTap: (index){
                cubit.chaneCurrentItem(index);
              },
              items: [
                BottomNavigationBarItem(icon:Icon(Icons.task),label: 'Tasks'),
                BottomNavigationBarItem(icon:Icon(Icons.archive),label: 'Archived'),
                BottomNavigationBarItem(icon:Icon(Icons.done),label: 'Done'),
              ],
            ),
          );
        }
    ) );}
}
