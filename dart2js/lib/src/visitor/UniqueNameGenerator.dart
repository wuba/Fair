class UniqueNameGenerator {
  static final _instance = UniqueNameGenerator._internal();
  int seq = 0;

  factory UniqueNameGenerator() => _instance;

  void reset() {
    _instance.seq = 0;
  }

  String next() {
    seq++;
    return '__temp_f_$seq\_\_';
  }

  UniqueNameGenerator._internal();
}