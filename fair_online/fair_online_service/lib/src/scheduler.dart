library services.scheduler;

import 'dart:async';
import 'dart:collection';

class TaskScheduler {
  final Queue<_Task<dynamic>> _taskQueue = Queue<_Task<dynamic>>();
  bool _isActive = false;

  int get queueCount => _taskQueue.length;

  Future<T> _performTask<T>(Task<T> task) {
    return task.perform().timeout(task.timeoutDuration);
  }

  Future<T> schedule<T>(Task<T> task) {
    if (!_isActive) {
      _isActive = true;
      return _performTask(task).whenComplete(_next);
    }
    final taskResult = Completer<T>();
    _taskQueue.add(_Task<T>(task, taskResult));
    return taskResult.future;
  }

  void _next() {
    assert(_isActive);
    if (_taskQueue.isEmpty) {
      _isActive = false;
      return;
    }
    final first = _taskQueue.removeFirst();
    first.taskResult.complete(_performTask(first.task).whenComplete(_next));
  }
}

// Internal unit of scheduling.
class _Task<T> {
  final Task<T> task;
  final Completer<T> taskResult;

  _Task(this.task, this.taskResult);
}

// Public working data structure.
abstract class Task<T> {
  Future<T> perform();

  late Duration timeoutDuration;
}

class ClosureTask<T> extends Task<T> {
  final Future<T> Function() _closure;

  ClosureTask(this._closure, {required Duration timeoutDuration}) {
    this.timeoutDuration = timeoutDuration;
  }

  @override
  Future<T> perform() {
    return _closure();
  }
}
