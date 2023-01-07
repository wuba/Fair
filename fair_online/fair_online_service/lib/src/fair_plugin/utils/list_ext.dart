extension ListExt<T> on List<T> {
  T? firstWhereOrNull(bool Function(T element) test, {T? Function()? orElse}) {
    try {
      return firstWhere(test);
    } catch (e) {
      if (orElse == null) {
        return null;
      } else {
        return orElse.call();
      }
    }
  }

  T? singleWhereOrNull(bool Function(T element) test, {T? Function()? orElse}) {
    try {
      return singleWhere(test);
    } catch (e) {
      if (orElse == null) {
        return null;
      } else {
        return orElse.call();
      }
    }
  }
}
