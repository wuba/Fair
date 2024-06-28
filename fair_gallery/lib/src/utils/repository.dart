import 'dart:async';

import 'package:fair/fair.dart';
import 'package:loading_more_list/loading_more_list.dart';

class LoadingMoreRepository extends LoadingMoreBase<dynamic> {
  LoadingMoreRepository();
  bool _hasMore = true;
  @override
  bool get hasMore =>
      _hasMore && (_maxLength != null ? length < _maxLength! : true);
  DateTime get dateTimeNow => _dateTimeNow;
  DateTime _dateTimeNow = DateTime.now();
  void Function(Map input)? _onLoadData;
  int? _maxLength;
  bool? _notifyStateChanged;

  static LoadingMoreRepository onLoadData(
    LoadingMoreRepository repository,
    void Function(Map input) onLoadData, {
    bool? notifyStateChanged,
    int? maxLength,
  }) {
    repository._onLoadData = onLoadData;
    repository._maxLength = maxLength;
    repository._notifyStateChanged = notifyStateChanged;
    return repository;
  }

  @override
  Future<bool> refresh([bool notifyStateChanged = false]) async {
    _hasMore = true;
    final bool result =
        await super.refresh(_notifyStateChanged ?? notifyStateChanged);
    _dateTimeNow = DateTime.now();
    return result;
  }

  @override
  Future<bool> loadData([bool isloadMoreAction = false]) async {
    try {
      String futureId =
          'LoadingMoreRepository${DateTime.now().microsecondsSinceEpoch}';
      Completer completer = CompleterPlugin.createCompleter(futureId);
      _onLoadData?.call({
        'futureId': futureId,
        'isloadMoreAction': isloadMoreAction,
      });
      var response = await completer.future;
      if (response == null) {
        return false;
      }

      var statusCode = response['statusCode'];
      var pageIndex = response['pageIndex'];
      if (pageIndex == 1) {
        clear();
      }
      if (statusCode != 200) {
        return false;
      }
      var list = response['list'] ?? [];

      addAll(list);
      _hasMore = list.isNotEmpty;
      return true;
    } catch (exception) {
      return false;
    }
  }
}
