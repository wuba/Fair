import 'package:fair_provider/fair_provider.dart';

class TimeRecord {
  TimeRecord(this.tag);

  String? tag;

  late DateTime _startTime;
  late DateTime _endTime;

  void start() {
    _startTime = DateTime.now();
  }

  void done() {
    _endTime = DateTime.now();
    final duration = _endTime.difference(_startTime);
    final milliseconds = duration.inMilliseconds;
    if (providerLogOn) {
      print('耗时统计 Time elapsed: $milliseconds milliseconds');
    }
  }
}
