import 'package:bloc/bloc.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'counter_observer.dart';

void main() {
  Bloc.observer = CounterObserver();
  runApp(FairApp(child: const CounterApp()));
}
