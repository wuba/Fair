/// A benchmark library. This library supports running benchmarks which can
/// run asynchronously.
library services.bench;

import 'dart:async';
import 'dart:convert' show json;

abstract class Benchmark {
  final String name;

  Benchmark(this.name);

  Future<void> init() => Future.value();

  Future<void> perform();

  /// Called once when this benchmark will no longer be used.
  Future<void> tearDown() => Future<void>.value();

  @override
  String toString() => name;
}

typedef BenchmarkLogger = void Function(String str);

class BenchmarkHarness {
  final bool asJson;
  final BenchmarkLogger logger;

  BenchmarkHarness({required this.asJson, this.logger = print});

  Future<void> benchmark(List<Benchmark> benchmarks) async {
    log('Running ${benchmarks.length} benchmarks.');
    log('');

    final results = <BenchMarkResult>[];

    await Future.forEach(benchmarks, (Benchmark benchmark) => benchmark.init());

    return Future.forEach(benchmarks, (Benchmark benchmark) {
      return benchmarkSingle(benchmark).then((BenchMarkResult result) {
        results.add(result);
      });
    }).then((_) {
      if (asJson) {
        logger(json.encode(results
            .map((BenchMarkResult r) =>
                <String, num>{r.benchmark.name: r.averageMilliseconds()})
            .toList()));
      }
    });
  }

  Future<BenchMarkResult> benchmarkSingle(Benchmark benchmark) {
    return _warmup(benchmark).then((_) {
      return _measure(benchmark);
    }).then((BenchMarkResult result) {
      logResult(result);
      return result;
    }).whenComplete(() {
      return benchmark.tearDown().catchError((dynamic e) => null);
    });
  }

  void log(String message) {
    if (!asJson) logger(message);
  }

  void logResult(BenchMarkResult result) {
    if (!asJson) logger(result.toString());
  }

  Future<BenchMarkResult> _warmup(Benchmark benchmark) {
    return _time(benchmark, 2, 1000);
  }

  Future<BenchMarkResult> _measure(Benchmark benchmark) {
    return _time(benchmark, 10, 2000, 10000);
  }

  Future<BenchMarkResult> _time(
      Benchmark benchmark, int minIterations, int minMillis,
      [int? maxMillis]) {
    final result = BenchMarkResult(benchmark);
    final timer = Stopwatch()..start();

    return Future.doWhile(() {
      if (result.iteration >= minIterations &&
          timer.elapsedMilliseconds >= minMillis) {
        return false;
      }

      if (maxMillis != null && timer.elapsedMilliseconds >= maxMillis) {
        return false;
      }

      result.iteration++;
      return benchmark.perform().then((_) => true);
    }).then((_) {
      timer.stop();
      result.microseconds = timer.elapsedMicroseconds;
      return result;
    });
  }
}

class BenchMarkResult {
  final Benchmark benchmark;
  int iteration = 0;
  int microseconds = 0;

  BenchMarkResult(this.benchmark);

  double averageMilliseconds() => (microseconds / iteration) / 1000.0;

  @override
  String toString() => '[${benchmark.name.padRight(26)}: '
      '${averageMilliseconds().toStringAsFixed(3).padLeft(8)}ms]';
}
