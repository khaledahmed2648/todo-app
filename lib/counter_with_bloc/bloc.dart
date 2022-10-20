
import 'package:counter_with_bloc1/counter_with_bloc/States.dart';
import 'package:counter_with_bloc1/counter_with_bloc/counter_events.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvents,CounterStates>{
  int Counter=0;

  CounterBloc(CounterStates initialState) : super(initialCounterState());
 static CounterBloc get(BuildContext context)=>BlocProvider.of(context);
@override
Stream<CounterStates> mapEventToState(CounterEvents event)async*{
  if(event is addCounterEvent)
    yield* changeValue('in');
  if(event is removeCounterEvent)
    yield* changeValue('dec');
}





  Stream<CounterStates> changeValue(String s)async*{

    switch(s){
      case'in':
        Counter++;
        break;
      case'dec':
        Counter--;
        break;
    }



    yield succesCounterState();

  }




}


