import 'package:bloc/bloc.dart';

/// {@template counter_observer}
/// [BlocObserver] for the counter application which
/// observes all [Cubit] state changes.
/// {@endtemplate}
class CounterObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }
}
