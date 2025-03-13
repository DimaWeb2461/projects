import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter__state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterChanged(0));


  int _counter = 0;
  increment() {
    if (_counter == 10) {
      emit(CounterError("message error !!!"));
      return;
    }
    _counter ++;
    emit(CounterChanged(_counter));
  }
  decrement() {
    _counter --;
    emit(CounterChanged(_counter));
  }
}
