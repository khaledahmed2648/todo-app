import 'package:counter_with_bloc1/counter_with_bloc/States.dart';
import 'package:counter_with_bloc1/counter_with_bloc/bloc.dart';
import 'package:counter_with_bloc1/counter_with_bloc/counter_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CounterScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider<CounterBloc>(
        create:(context)=>CounterBloc(initialCounterState()),
      child:BlocConsumer<CounterBloc,CounterStates>(
        listener: (context, state) {},
        builder: (context,states){
          return Scaffold(
            appBar: AppBar(
              title:Text(
                  'Counter'

              ),
              backgroundColor: Colors.lightBlue,
            ),
            body: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed:(){
                      CounterBloc.get(context).add(addCounterEvent());
                    },
                    child: Icon(
                        Icons.add
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    '${CounterBloc.get(context).Counter}',
                    style: TextStyle(
                        fontSize: 15
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed:(){
                      CounterBloc.get(context).add(removeCounterEvent(),);

                    },
                    child: Icon(
                        Icons.remove
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      )
       ,
    );
  }
}
