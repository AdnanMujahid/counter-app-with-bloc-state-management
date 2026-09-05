import 'package:counterapp/Bloc/counter_event.dart';
import 'package:counterapp/Bloc/counter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState>{
  CounterBloc():super(CounterState(0)){
    on<increment>((event, emit){
      emit(CounterState(state.counter + 1));
    });
    on<decrement>((event, emit){
      emit(CounterState(state.counter - 1));
    });
  }
}