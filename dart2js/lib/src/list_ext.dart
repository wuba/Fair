extension ListExt<T> on List<T> {
  T? firstWhereOrNull(bool test(T element), {T? orElse()?}) {
    try {
      return this.firstWhere(test);
    } catch (e) {
      if (orElse == null) {
        return null;
      } else {
        return orElse.call();
      }
    }
  }

  T? singleWhereOrNull(bool test(T element), {T? orElse()?}) {
    try {
      return this.singleWhere(test);
    } catch (e) {
      if (orElse == null) {
        return null;
      } else {
        return orElse.call();
      }
    }
  }
}
