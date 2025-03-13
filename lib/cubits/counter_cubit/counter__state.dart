part of 'counter__cubit.dart';

@immutable
sealed class CounterState {}

final class CounterInitial extends CounterState {}
final class CounterLoading extends CounterState {

}
final class CounterError extends CounterState {
  final String message;

  CounterError(this.message);
}
final class CounterChanged extends CounterState {
  final int counter;

  CounterChanged(this.counter);
}
