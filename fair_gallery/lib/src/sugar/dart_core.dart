// ignore_for_file: deprecated_member_use, prefer_single_quotes

import 'dart:math';

/// Iterable Sugar
class SugarIterable {
  SugarIterable._();

  /// A new `Iterator` that allows iterating the elements of this `Iterable`.
  ///
  /// Iterable classes may specify the iteration order of their elements
  /// (for example [List] always iterate in index order),
  /// or they may leave it unspecified (for example a hash-based [Set]
  /// may iterate in any order).
  ///
  /// Each time `iterator` is read, it returns a new iterator,
  /// which can be used to iterate through all the elements again.
  /// The iterators of the same iterable can be stepped through independently,
  /// but should return the same elements in the same order,
  /// as long as the underlying collection isn't changed.
  ///
  /// Modifying the collection may cause new iterators to produce
  /// different elements, and may change the order of existing elements.
  /// A [List] specifies its iteration order precisely,
  /// so modifying the list changes the iteration order predictably.
  /// A hash-based [Set] may change its iteration order completely
  /// when adding a new element to the set.
  ///
  /// Modifying the underlying collection after creating the new iterator
  /// may cause an error the next time [Iterator.moveNext] is called
  /// on that iterator.
  /// Any *modifiable* iterable class should specify which operations will
  /// break iteration.
  static Iterator<dynamic> iterator(Iterable input) => input.iterator;

  /// The number of elements in [this].
  ///
  /// Counting all elements may involve iterating through all elements and can
  /// therefore be slow.
  /// Some iterables have a more efficient way to find the number of elements.
  /// These *must* override the default implementation of `length`.
  static int length(Iterable input) => input.length;

  /// Whether this collection has no elements.
  ///
  /// May be computed by checking if `iterator.moveNext()` returns `false`.
  ///
  /// Example:
  /// ```dart
  /// final emptyList = <int>[];
  /// print(emptyList.isEmpty); // true;
  /// print(emptyList.iterator.moveNext()); // false
  /// ```
  static bool isEmpty(Iterable input) => input.isEmpty;

  /// Whether this collection has at least one element.
  ///
  /// May be computed by checking if `iterator.moveNext()` returns `true`.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>{1, 2, 3};
  /// print(numbers.isNotEmpty); // true;
  /// print(numbers.iterator.moveNext()); // true
  /// ```
  static bool isNotEmpty(Iterable input) => input.isNotEmpty;

  /// The first element.
  ///
  /// Throws a [StateError] if `this` is empty.
  /// Otherwise returns the first element in the iteration order,
  /// equivalent to `this.elementAt(0)`.
  static dynamic first(Iterable input) => input.first;

  /// The last element.
  ///
  /// Throws a [StateError] if `this` is empty.
  /// Otherwise may iterate through the elements and returns the last one
  /// seen.
  /// Some iterables may have more efficient ways to find the last element
  /// (for example a list can directly access the last element,
  /// without iterating through the previous ones).
  static dynamic last(Iterable input) => input.last;

  /// Checks that this iterable has only one element, and returns that element.
  ///
  /// Throws a [StateError] if `this` is empty or has more than one element.
  /// This operation will not iterate past the second element.
  static dynamic single(Iterable input) => input.single;

  /// Adapts [source] to be an `Iterable<T>`.
  ///
  /// Any time the iterable would produce an element that is not a [T],
  /// the element access will throw. If all elements of [source] are actually
  /// instances of [T], or if only elements that are actually instances of [T]
  /// are accessed, then the resulting iterable can be used as an `Iterable<T>`.
  static Iterable<T> castFrom<S, T>(Iterable<S> source) => Iterable.castFrom(
        source,
      );

  /// A view of this iterable as an iterable of [R] instances.
  ///
  /// If this iterable only contains instances of [R], all operations
  /// will work correctly. If any operation tries to access an element
  /// that is not an instance of [R], the access will throw instead.
  ///
  /// When the returned iterable creates a new object that depends on
  /// the type [R], e.g., from [toList], it will have exactly the type [R].
  static Iterable<R> cast<R>(
    Iterable input,
  ) =>
      input.cast();

  /// Creates the lazy concatenation of this iterable and [other].
  ///
  /// The returned iterable will provide the same elements as this iterable,
  /// and, after that, the elements of [other], in the same order as in the
  /// original iterables.
  ///
  /// Example:
  /// ```dart
  /// var planets = <String>['Earth', 'Jupiter'];
  /// var updated = planets.followedBy(['Mars', 'Venus']);
  /// print(updated); // (Earth, Jupiter, Mars, Venus)
  /// ```
  static Iterable<dynamic> followedBy(
          Iterable input, Iterable<dynamic> other) =>
      input.followedBy(
        other,
      );

  /// The current elements of this iterable modified by [toElement].
  ///
  /// Returns a new lazy [Iterable] with elements that are created by
  /// calling `toElement` on each element of this `Iterable` in
  /// iteration order.
  ///
  /// The returned iterable is lazy, so it won't iterate the elements of
  /// this iterable until it is itself iterated, and then it will apply
  /// [toElement] to create one element at a time.
  /// The converted elements are not cached.
  /// Iterating multiple times over the returned [Iterable]
  /// will invoke the supplied [toElement] function once per element
  /// for on each iteration.
  ///
  /// Methods on the returned iterable are allowed to omit calling `toElement`
  /// on any element where the result isn't needed.
  /// For example, [elementAt] may call `toElement` only once.
  ///
  /// Equivalent to:
  /// ```
  /// Iterable<T> map<T>(T toElement(E e)) sync* {
  ///   for (var value in this) {
  ///     yield toElement(value);
  ///   }
  /// }
  /// ```
  /// Example:
  /// ```dart import:convert
  /// var products = jsonDecode('''
  /// [
  ///   {"name": "Screwdriver", "price": 42.00},
  ///   {"name": "Wingnut", "price": 0.50}
  /// ]
  /// ''');
  /// var values = products.map((product) => product['price'] as double);
  /// var totalPrice = values.fold(0.0, (a, b) => a + b); // 42.5.
  /// ```
  static Iterable<T> map<T>(Iterable input, T Function(dynamic) toElement) =>
      input.map(
        toElement,
      );

  /// Creates a new lazy [Iterable] with all elements that satisfy the
  /// predicate [test].
  ///
  /// The matching elements have the same order in the returned iterable
  /// as they have in [iterator].
  ///
  /// This method returns a view of the mapped elements.
  /// As long as the returned [Iterable] is not iterated over,
  /// the supplied function [test] will not be invoked.
  /// Iterating will not cache results, and thus iterating multiple times over
  /// the returned [Iterable] may invoke the supplied
  /// function [test] multiple times on the same element.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.where((x) => x < 5); // (1, 2, 3)
  /// result = numbers.where((x) => x > 5); // (6, 7)
  /// result = numbers.where((x) => x.isEven); // (2, 6)
  /// ```
  static Iterable<dynamic> where(Iterable input, bool Function(dynamic) test) =>
      input.where(
        test,
      );

  /// Creates a new lazy [Iterable] with all elements that have type [T].
  ///
  /// The matching elements have the same order in the returned iterable
  /// as they have in [iterator].
  ///
  /// This method returns a view of the mapped elements.
  /// Iterating will not cache results, and thus iterating multiple times over
  /// the returned [Iterable] may yield different results,
  /// if the underlying elements change between iterations.
  static Iterable<T> whereType<T>(
    Iterable input,
  ) =>
      input.whereType();

  /// Expands each element of this [Iterable] into zero or more elements.
  ///
  /// The resulting Iterable runs through the elements returned
  /// by [toElements] for each element of this, in iteration order.
  ///
  /// The returned [Iterable] is lazy, and calls [toElements] for each element
  /// of this iterable every time the returned iterable is iterated.
  ///
  /// Example:
  /// ```dart
  /// Iterable<int> count(int n) sync* {
  ///   for (var i = 1; i <= n; i++) {
  ///     yield i;
  ///    }
  ///  }
  ///
  /// var numbers = [1, 3, 0, 2];
  /// print(numbers.expand(count)); // (1, 1, 2, 3, 1, 2)
  /// ```
  ///
  /// Equivalent to:
  /// ```
  /// Iterable<T> expand<T>(Iterable<T> toElements(E e)) sync* {
  ///   for (var value in this) {
  ///     yield* toElements(value);
  ///   }
  /// }
  /// ```
  static Iterable<T> expand<T>(
          Iterable input, Iterable<T> Function(dynamic) toElements) =>
      input.expand(
        toElements,
      );

  /// Whether the collection contains an element equal to [element].
  ///
  /// This operation will check each element in order for being equal to
  /// [element], unless it has a more efficient way to find an element
  /// equal to [element].
  /// Stops iterating on the first equal element.
  ///
  /// The equality used to determine whether [element] is equal to an element of
  /// the iterable defaults to the [Object.==] of the element.
  ///
  /// Some types of iterable may have a different equality used for its elements.
  /// For example, a [Set] may have a custom equality
  /// (see [Set.identity]) that its `contains` uses.
  /// Likewise the `Iterable` returned by a [Map.keys] call
  /// should use the same equality that the `Map` uses for keys.
  ///
  /// Example:
  /// ```dart
  /// final gasPlanets = <int, String>{1: 'Jupiter', 2: 'Saturn'};
  /// final containsOne = gasPlanets.keys.contains(1); // true
  /// final containsFive = gasPlanets.keys.contains(5); // false
  /// final containsJupiter = gasPlanets.values.contains('Jupiter'); // true
  /// final containsMercury = gasPlanets.values.contains('Mercury'); // false
  /// ```
  static bool contains(Iterable input, Object? element) => input.contains(
        element,
      );

  /// Invokes [action] on each element of this iterable in iteration order.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 6, 7];
  /// numbers.forEach(print);
  /// // 1
  /// // 2
  /// // 6
  /// // 7
  /// ```
  static void forEach(Iterable input, void Function(dynamic) action) =>
      input.forEach(
        action,
      );

  /// Reduces a collection to a single value by iteratively combining elements
  /// of the collection using the provided function.
  ///
  /// The iterable must have at least one element.
  /// If it has only one element, that element is returned.
  ///
  /// Otherwise this method starts with the first element from the iterator,
  /// and then combines it with the remaining elements in iteration order,
  /// as if by:
  /// ```
  /// E value = iterable.first;
  /// iterable.skip(1).forEach((element) {
  ///   value = combine(value, element);
  /// });
  /// return value;
  /// ```
  /// Example of calculating the sum of an iterable:
  /// ```dart
  /// final numbers = <double>[10, 2, 5, 0.5];
  /// final result = numbers.reduce((value, element) => value + element);
  /// print(result); // 17.5
  /// ```
  static dynamic reduce(
          Iterable input, dynamic Function(dynamic, dynamic) combine) =>
      input.reduce(
        combine,
      );

  /// Reduces a collection to a single value by iteratively combining each
  /// element of the collection with an existing value
  ///
  /// Uses [initialValue] as the initial value,
  /// then iterates through the elements and updates the value with
  /// each element using the [combine] function, as if by:
  /// ```
  /// var value = initialValue;
  /// for (E element in this) {
  ///   value = combine(value, element);
  /// }
  /// return value;
  /// ```
  /// Example of calculating the sum of an iterable:
  /// ```dart
  /// final numbers = <double>[10, 2, 5, 0.5];
  /// const initialValue = 100.0;
  /// final result = numbers.fold<double>(
  ///     initialValue, (previousValue, element) => previousValue + element);
  /// print(result); // 117.5
  /// ```
  static T fold<T>(
          Iterable input, T initialValue, T Function(T, dynamic) combine) =>
      input.fold(
        initialValue,
        combine,
      );

  /// Checks whether every element of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns `false` if
  /// any of them make [test] return `false`, otherwise returns `true`.
  ///
  /// Example:
  /// ```dart
  /// final planetsByMass = <double, String>{0.06: 'Mercury', 0.81: 'Venus',
  ///   0.11: 'Mars'};
  /// // Checks whether all keys are smaller than 1.
  /// final every = planetsByMass.keys.every((key) => key < 1.0); // true
  /// ```
  static bool every(Iterable input, bool Function(dynamic) test) => input.every(
        test,
      );

  /// Converts each element to a [String] and concatenates the strings.
  ///
  /// Iterates through elements of this iterable,
  /// converts each one to a [String] by calling [Object.toString],
  /// and then concatenates the strings, with the
  /// [separator] string interleaved between the elements.
  ///
  /// Example:
  /// ```dart
  /// final planetsByMass = <double, String>{0.06: 'Mercury', 0.81: 'Venus',
  ///   0.11: 'Mars'};
  /// final joinedNames = planetsByMass.values.join('-'); // Mercury-Venus-Mars
  /// ```
  static String join(Iterable input, [String separator = ""]) => input.join(
        separator,
      );

  /// Checks whether any element of this iterable satisfies [test].
  ///
  /// Checks every element in iteration order, and returns `true` if
  /// any of them make [test] return `true`, otherwise returns false.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.any((element) => element >= 5); // true;
  /// result = numbers.any((element) => element >= 10); // false;
  /// ```
  static bool any(Iterable input, bool Function(dynamic) test) => input.any(
        test,
      );

  /// Creates a [List] containing the elements of this [Iterable].
  ///
  /// The elements are in iteration order.
  /// The list is fixed-length if [growable] is false.
  ///
  /// Example:
  /// ```dart
  /// final planets = <int, String>{1: 'Mercury', 2: 'Venus', 3: 'Mars'};
  /// final keysList = planets.keys.toList(growable: false); // [1, 2, 3]
  /// final valuesList =
  ///     planets.values.toList(growable: false); // [Mercury, Venus, Mars]
  /// ```
  static List<dynamic> toList(Iterable input, {bool growable = true}) =>
      input.toList(
        growable: growable,
      );

  /// Creates a [Set] containing the same elements as this iterable.
  ///
  /// The set may contain fewer elements than the iterable,
  /// if the iterable contains an element more than once,
  /// or it contains one or more elements that are equal.
  /// The order of the elements in the set is not guaranteed to be the same
  /// as for the iterable.
  ///
  /// Example:
  /// ```dart
  /// final planets = <int, String>{1: 'Mercury', 2: 'Venus', 3: 'Mars'};
  /// final valueSet = planets.values.toSet(); // {Mercury, Venus, Mars}
  /// ```
  static Set<dynamic> toSet(
    Iterable input,
  ) =>
      input.toSet();

  /// Creates a lazy iterable of the [count] first elements of this iterable.
  ///
  /// The returned `Iterable` may contain fewer than `count` elements, if `this`
  /// contains fewer than `count` elements.
  ///
  /// The elements can be computed by stepping through [iterator] until [count]
  /// elements have been seen.
  ///
  /// The `count` must not be negative.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// final result = numbers.take(4); // (1, 2, 3, 5)
  /// final takeAll = numbers.take(100); // (1, 2, 3, 5, 6, 7)
  /// ```
  static Iterable<dynamic> take(Iterable input, int count) => input.take(
        count,
      );

  /// Creates a lazy iterable of the leading elements satisfying [test].
  ///
  /// The filtering happens lazily. Every new iterator of the returned
  /// iterable starts iterating over the elements of `this`.
  ///
  /// The elements can be computed by stepping through [iterator] until an
  /// element is found where `test(element)` is false. At that point,
  /// the returned iterable stops (its `moveNext()` returns false).
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.takeWhile((x) => x < 5); // (1, 2, 3)
  /// result = numbers.takeWhile((x) => x != 3); // (1, 2)
  /// result = numbers.takeWhile((x) => x != 4); // (1, 2, 3, 5, 6, 7)
  /// result = numbers.takeWhile((x) => x.isOdd); // (1)
  /// ```
  static Iterable<dynamic> takeWhile(
          Iterable input, bool Function(dynamic) test) =>
      input.takeWhile(
        test,
      );

  /// Creates an [Iterable] that provides all but the first [count] elements.
  ///
  /// When the returned iterable is iterated, it starts iterating over `this`,
  /// first skipping past the initial [count] elements.
  /// If `this` has fewer than `count` elements, then the resulting Iterable is
  /// empty.
  /// After that, the remaining elements are iterated in the same order as
  /// in this iterable.
  ///
  /// Some iterables may be able to find later elements without first iterating
  /// through earlier elements, for example when iterating a [List].
  /// Such iterables are allowed to ignore the initial skipped elements.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// final result = numbers.skip(4); // (6, 7)
  /// final skipAll = numbers.skip(100); // () - no elements.
  /// ```
  ///
  /// The [count] must not be negative.
  static Iterable<dynamic> skip(Iterable input, int count) => input.skip(
        count,
      );

  /// Creates an `Iterable` that skips leading elements while [test] is satisfied.
  ///
  /// The filtering happens lazily. Every new [Iterator] of the returned
  /// iterable iterates over all elements of `this`.
  ///
  /// The returned iterable provides elements by iterating this iterable,
  /// but skipping over all initial elements where `test(element)` returns
  /// true. If all elements satisfy `test` the resulting iterable is empty,
  /// otherwise it iterates the remaining elements in their original order,
  /// starting with the first element for which `test(element)` returns `false`.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.skipWhile((x) => x < 5); // (5, 6, 7)
  /// result = numbers.skipWhile((x) => x != 3); // (3, 5, 6, 7)
  /// result = numbers.skipWhile((x) => x != 4); // ()
  /// result = numbers.skipWhile((x) => x.isOdd); // (2, 3, 5, 6, 7)
  /// ```
  static Iterable<dynamic> skipWhile(
          Iterable input, bool Function(dynamic) test) =>
      input.skipWhile(
        test,
      );

  /// The first element that satisfies the given predicate [test].
  ///
  /// Iterates through elements and returns the first to satisfy [test].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.firstWhere((element) => element < 5); // 1
  /// result = numbers.firstWhere((element) => element > 5); // 6
  /// result =
  ///     numbers.firstWhere((element) => element > 10, orElse: () => -1); // -1
  /// ```
  ///
  /// If no element satisfies [test], the result of invoking the [orElse]
  /// function is returned.
  /// If [orElse] is omitted, it defaults to throwing a [StateError].
  /// Stops iterating on the first matching element.
  static dynamic firstWhere(Iterable input, bool Function(dynamic) test,
          {dynamic Function()? orElse}) =>
      input.firstWhere(
        test,
        orElse: orElse,
      );

  /// The last element that satisfies the given predicate [test].
  ///
  /// An iterable that can access its elements directly may check its
  /// elements in any order (for example a list starts by checking the
  /// last element and then moves towards the start of the list).
  /// The default implementation iterates elements in iteration order,
  /// checks `test(element)` for each,
  /// and finally returns that last one that matched.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// var result = numbers.lastWhere((element) => element < 5); // 3
  /// result = numbers.lastWhere((element) => element > 5); // 7
  /// result = numbers.lastWhere((element) => element > 10,
  ///     orElse: () => -1); // -1
  /// ```
  ///
  /// If no element satisfies [test], the result of invoking the [orElse]
  /// function is returned.
  /// If [orElse] is omitted, it defaults to throwing a [StateError].
  static dynamic lastWhere(Iterable input, bool Function(dynamic) test,
          {dynamic Function()? orElse}) =>
      input.lastWhere(
        test,
        orElse: orElse,
      );

  /// The single element that satisfies [test].
  ///
  /// Checks elements to see if `test(element)` returns true.
  /// If exactly one element satisfies [test], that element is returned.
  /// If more than one matching element is found, throws [StateError].
  /// If no matching element is found, returns the result of [orElse].
  /// If [orElse] is omitted, it defaults to throwing a [StateError].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[2, 2, 10];
  /// var result = numbers.singleWhere((element) => element > 5); // 10
  /// ```
  /// When no matching element is found, the result of calling [orElse] is
  /// returned instead.
  /// ```dart continued
  /// result = numbers.singleWhere((element) => element == 1,
  ///     orElse: () => -1); // -1
  /// ```
  /// There must not be more than one matching element.
  /// ```dart continued
  /// result = numbers.singleWhere((element) => element == 2); // Throws Error.
  /// ```
  static dynamic singleWhere(Iterable input, bool Function(dynamic) test,
          {dynamic Function()? orElse}) =>
      input.singleWhere(
        test,
        orElse: orElse,
      );

  /// Returns the [index]th element.
  ///
  /// The [index] must be non-negative and less than [length].
  /// Index zero represents the first element (so `iterable.elementAt(0)` is
  /// equivalent to `iterable.first`).
  ///
  /// May iterate through the elements in iteration order, ignoring the
  /// first [index] elements and then returning the next.
  /// Some iterables may have a more efficient way to find the element.
  ///
  /// Example:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 5, 6, 7];
  /// final elementAt = numbers.elementAt(4); // 6
  /// ```
  static dynamic elementAt(Iterable input, int index) => input.elementAt(
        index,
      );

  /// Returns a string representation of (some of) the elements of `this`.
  ///
  /// Elements are represented by their own `toString` results.
  ///
  /// The default representation always contains the first three elements.
  /// If there are less than a hundred elements in the iterable, it also
  /// contains the last two elements.
  ///
  /// If the resulting string isn't above 80 characters, more elements are
  /// included from the start of the iterable.
  ///
  /// The conversion may omit calling `toString` on some elements if they
  /// are known to not occur in the output, and it may stop iterating after
  /// a hundred elements.
  static String iterableToString(
    Iterable input,
  ) =>
      input.toString();

  /// Convert an `Iterable` to a string like [Iterable.toString].
  ///
  /// Allows using other delimiters than '(' and ')'.
  ///
  /// Handles circular references where converting one of the elements
  /// to a string ends up converting [iterable] to a string again.
  static String iterableToShortString(Iterable<dynamic> iterable,
          [String leftDelimiter = '(', String rightDelimiter = ')']) =>
      Iterable.iterableToShortString(
        iterable,
        leftDelimiter,
        rightDelimiter,
      );

  /// Converts an `Iterable` to a string.
  ///
  /// Converts each elements to a string, and separates the results by ", ".
  /// Then wraps the result in [leftDelimiter] and [rightDelimiter].
  ///
  /// Unlike [iterableToShortString], this conversion doesn't omit any
  /// elements or puts any limit on the size of the result.
  ///
  /// Handles circular references where converting one of the elements
  /// to a string ends up converting [iterable] to a string again.
  static String iterableToFullString(Iterable<dynamic> iterable,
          [String leftDelimiter = '(', String rightDelimiter = ')']) =>
      Iterable.iterableToFullString(
        iterable,
        leftDelimiter,
        rightDelimiter,
      );
}

/// Map Sugar
class SugarMap {
  SugarMap._();

  /// The map entries of [this].
  static Iterable<MapEntry<dynamic, dynamic>> entries(Map input) =>
      input.entries;

  /// The keys of [this].
  ///
  /// The returned iterable has efficient `length` and `contains` operations,
  /// based on [length] and [containsKey] of the map.
  ///
  /// The order of iteration is defined by the individual `Map` implementation,
  /// but must be consistent between changes to the map.
  ///
  /// Modifying the map while iterating the keys may break the iteration.
  static Iterable<dynamic> keys(Map input) => input.keys;

  /// The values of [this].
  ///
  /// The values are iterated in the order of their corresponding keys.
  /// This means that iterating [keys] and [values] in parallel will
  /// provide matching pairs of keys and values.
  ///
  /// The returned iterable has an efficient `length` method based on the
  /// [length] of the map. Its [Iterable.contains] method is based on
  /// `==` comparison.
  ///
  /// Modifying the map while iterating the values may break the iteration.
  static Iterable<dynamic> values(Map input) => input.values;

  /// The number of key/value pairs in the map.
  static int length(Map input) => input.length;

  /// Whether there is no key/value pair in the map.
  static bool isEmpty(Map input) => input.isEmpty;

  /// Whether there is at least one key/value pair in the map.
  static bool isNotEmpty(Map input) => input.isNotEmpty;

  /// Whether this map contains the given [value].
  ///
  /// Returns true if any of the values in the map are equal to `value`
  /// according to the `==` operator.
  /// ```dart
  /// final moonCount = <String, int>{'Mercury': 0, 'Venus': 0, 'Earth': 1,
  ///   'Mars': 2, 'Jupiter': 79, 'Saturn': 82, 'Uranus': 27, 'Neptune': 14 };
  /// final moons3 = moonCount.containsValue(3); // false
  /// final moons82 = moonCount.containsValue(82); // true
  /// ```
  static bool containsValue(Map input, Object? value) => input.containsValue(
        value,
      );

  /// Whether this map contains the given [key].
  ///
  /// Returns true if any of the keys in the map are equal to `key`
  /// according to the equality used by the map.
  /// ```dart
  /// final moonCount = <String, int>{'Mercury': 0, 'Venus': 0, 'Earth': 1,
  ///   'Mars': 2, 'Jupiter': 79, 'Saturn': 82, 'Uranus': 27, 'Neptune': 14 };
  /// final containsUranus = moonCount.containsKey('Uranus'); // true
  /// final containsPluto = moonCount.containsKey('Pluto'); // false
  /// ```
  static bool containsKey(Map input, Object? key) => input.containsKey(
        key,
      );

  /// The value for the given [key], or `null` if [key] is not in the map.
  ///
  /// Some maps allow `null` as a value.
  /// For those maps, a lookup using this operator cannot distinguish between a
  /// key not being in the map, and the key being there with a `null` value.
  /// Methods like [containsKey] or [putIfAbsent] can be used if the distinction
  /// is important.
  static dynamic get(Map input, Object? key) => input[key];

  /// Associates the [key] with the given [value].
  ///
  /// If the key was already in the map, its associated value is changed.
  /// Otherwise the key/value pair is added to the map.
  static void set(Map input, dynamic key, dynamic value) => input[key] = value;

  /// Adds all key/value pairs of [newEntries] to this map.
  ///
  /// If a key of [newEntries] is already in this map,
  /// the corresponding value is overwritten.
  ///
  /// The operation is equivalent to doing `this[entry.key] = entry.value`
  /// for each [MapEntry] of the iterable.
  /// ```dart
  /// final planets = <int, String>{1: 'Mercury', 2: 'Venus',
  ///   3: 'Earth', 4: 'Mars'};
  /// final gasGiants = <int, String>{5: 'Jupiter', 6: 'Saturn'};
  /// final iceGiants = <int, String>{7: 'Uranus', 8: 'Neptune'};
  /// planets.addEntries(gasGiants.entries);
  /// planets.addEntries(iceGiants.entries);
  /// print(planets);
  /// // {1: Mercury, 2: Venus, 3: Earth, 4: Mars, 5: Jupiter, 6: Saturn,
  /// //  7: Uranus, 8: Neptune}
  /// ```
  static void addEntries(
          Map input, Iterable<MapEntry<dynamic, dynamic>> newEntries) =>
      input.addEntries(
        newEntries,
      );

  /// Updates the value for the provided [key].
  ///
  /// Returns the new value associated with the key.
  ///
  /// If the key is present, invokes [update] with the current value and stores
  /// the new value in the map.
  ///
  /// If the key is not present and [ifAbsent] is provided, calls [ifAbsent]
  /// and adds the key with the returned value to the map.
  ///
  /// If the key is not present, [ifAbsent] must be provided.
  /// ```dart
  /// final planetsFromSun = <int, String>{1: 'Mercury', 2: 'unknown',
  ///   3: 'Earth'};
  /// // Update value for known key value 2.
  /// planetsFromSun.update(2, (value) => 'Venus');
  /// print(planetsFromSun); // {1: Mercury, 2: Venus, 3: Earth}
  ///
  /// final largestPlanets = <int, String>{1: 'Jupiter', 2: 'Saturn',
  ///   3: 'Neptune'};
  /// // Key value 8 is missing from list, add it using [ifAbsent].
  /// largestPlanets.update(8, (value) => 'New', ifAbsent: () => 'Mercury');
  /// print(largestPlanets); // {1: Jupiter, 2: Saturn, 3: Neptune, 8: Mercury}
  /// ```
  static dynamic update(
          Map input, dynamic key, dynamic Function(dynamic) update,
          {dynamic Function()? ifAbsent}) =>
      input.update(
        key,
        update,
        ifAbsent: ifAbsent,
      );

  /// Updates all values.
  ///
  /// Iterates over all entries in the map and updates them with the result
  /// of invoking [update].
  /// ```dart
  /// final terrestrial = <int, String>{1: 'Mercury', 2: 'Venus', 3: 'Earth'};
  /// terrestrial.updateAll((key, value) => value.toUpperCase());
  /// print(terrestrial); // {1: MERCURY, 2: VENUS, 3: EARTH}
  /// ```
  static void updateAll(Map input, dynamic Function(dynamic, dynamic) update) =>
      input.updateAll(
        update,
      );

  /// Removes all entries of this map that satisfy the given [test].
  /// ```dart
  /// final terrestrial = <int, String>{1: 'Mercury', 2: 'Venus', 3: 'Earth'};
  /// terrestrial.removeWhere((key, value) => value.startsWith('E'));
  /// print(terrestrial); // {1: Mercury, 2: Venus}
  /// ```
  static void removeWhere(Map input, bool Function(dynamic, dynamic) test) =>
      input.removeWhere(
        test,
      );

  /// Look up the value of [key], or add a new entry if it isn't there.
  ///
  /// Returns the value associated to [key], if there is one.
  /// Otherwise calls [ifAbsent] to get a new value, associates [key] to
  /// that value, and then returns the new value.
  /// ```dart
  /// final diameters = <num, String>{1.0: 'Earth'};
  /// final otherDiameters = <double, String>{0.383: 'Mercury', 0.949: 'Venus'};
  ///
  /// for (final item in otherDiameters.entries) {
  ///   diameters.putIfAbsent(item.key, () => item.value);
  /// }
  /// print(diameters); // {1.0: Earth, 0.383: Mercury, 0.949: Venus}
  ///
  /// // If the key already exists, the current value is returned.
  /// final result = diameters.putIfAbsent(0.383, () => 'Random');
  /// print(result); // Mercury
  /// print(diameters); // {1.0: Earth, 0.383: Mercury, 0.949: Venus}
  /// ```
  /// Calling [ifAbsent] must not add or remove keys from the map.
  static dynamic putIfAbsent(
          Map input, dynamic key, dynamic Function() ifAbsent) =>
      input.putIfAbsent(
        key,
        ifAbsent,
      );

  /// Adds all key/value pairs of [other] to this map.
  ///
  /// If a key of [other] is already in this map, its value is overwritten.
  ///
  /// The operation is equivalent to doing `this[key] = value` for each key
  /// and associated value in other. It iterates over [other], which must
  /// therefore not change during the iteration.
  /// ```dart
  /// final planets = <int, String>{1: 'Mercury', 2: 'Earth'};
  /// planets.addAll({5: 'Jupiter', 6: 'Saturn'});
  /// print(planets); // {1: Mercury, 2: Earth, 5: Jupiter, 6: Saturn}
  /// ```
  static void addAll(Map input, Map<dynamic, dynamic> other) => input.addAll(
        other,
      );

  /// Removes [key] and its associated value, if present, from the map.
  ///
  /// Returns the value associated with `key` before it was removed.
  /// Returns `null` if `key` was not in the map.
  ///
  /// Note that some maps allow `null` as a value,
  /// so a returned `null` value doesn't always mean that the key was absent.
  /// ```dart
  /// final terrestrial = <int, String>{1: 'Mercury', 2: 'Venus', 3: 'Earth'};
  /// final removedValue = terrestrial.remove(2); // Venus
  /// print(terrestrial); // {1: Mercury, 3: Earth}
  /// ```
  static dynamic remove(Map input, Object? key) => input.remove(
        key,
      );

  /// Removes all entries from the map.
  ///
  /// After this, the map is empty.
  /// ```dart
  /// final planets = <int, String>{1: 'Mercury', 2: 'Venus', 3: 'Earth'};
  /// planets.clear(); // {}
  /// ```
  static void clear(
    Map input,
  ) =>
      input.clear();

  /// Applies [action] to each key/value pair of the map.
  ///
  /// Calling `action` must not add or remove keys from the map.
  /// ```dart
  /// final planetsByMass = <num, String>{0.81: 'Venus', 1: 'Earth',
  ///   0.11: 'Mars', 17.15: 'Neptune'};
  ///
  /// planetsByMass.forEach((key, value) {
  ///   print('$key: $value');
  ///   // 0.81: Venus
  ///   // 1: Earth
  ///   // 0.11: Mars
  ///   // 17.15: Neptune
  /// });
  /// ```
  static void forEach(Map input, void Function(dynamic, dynamic) action) =>
      input.forEach(
        action,
      );
}

/// Bool Sugar
class SugarBool {
  SugarBool._();

  // !input
  static bool invert(bool input) => !input;

  /// Parses [source] as an, optionally case-insensitive, boolean literal.
  ///
  /// If [caseSensitive] is `true`, which is the default,
  /// the only accepted inputs are the strings `"true"` and `"false"`,
  /// which returns the results `true` and `false` respectively.
  ///
  /// If [caseSensitive] is `false`, any combination of upper and lower case
  /// ASCII letters in the words `"true"` and `"false"` are accepted,
  /// as if the input was first lower-cased.
  ///
  /// Throws a [FormatException] if the [source] string does not contain
  /// a valid boolean literal.
  ///
  /// Rather than throwing and immediately catching the [FormatException],
  /// instead use [tryParse] to handle a potential parsing error.
  ///
  /// Example:
  /// ```dart
  /// print(bool.parse('true')); // true
  /// print(bool.parse('false')); // false
  /// print(bool.parse('TRUE')); // throws FormatException
  /// print(bool.parse('TRUE', caseSensitive: false)); // true
  /// print(bool.parse('FALSE', caseSensitive: false)); // false
  /// print(bool.parse('NO')); // throws FormatException
  /// print(bool.parse('YES')); // throws FormatException
  /// print(bool.parse('0')); // throws FormatException
  /// print(bool.parse('1')); // throws FormatException
  /// ```
  static bool parse(String source, {bool caseSensitive = true}) => bool.parse(
        source,
        caseSensitive: caseSensitive,
      );

  /// Parses [source] as an, optionally case-insensitive, boolean literal.
  ///
  /// If [caseSensitive] is `true`, which is the default,
  /// the only accepted inputs are the strings `"true"` and `"false"`,
  /// which returns the results `true` and `false` respectively.
  ///
  /// If [caseSensitive] is `false`, any combination of upper and lower case
  /// ASCII letters in the words `"true"` and `"false"` are accepted,
  /// as if the input was first lower-cased.
  ///
  /// Returns `null` if the [source] string does not contain a valid
  /// boolean literal.
  ///
  /// If the input can be assumed to be valid, use [bool.parse] to avoid
  /// having to deal with a possible `null` result.
  ///
  /// Example:
  /// ```dart
  /// print(bool.tryParse('true')); // true
  /// print(bool.tryParse('false')); // false
  /// print(bool.tryParse('TRUE')); // null
  /// print(bool.tryParse('TRUE', caseSensitive: false)); // true
  /// print(bool.tryParse('FALSE', caseSensitive: false)); // false
  /// print(bool.tryParse('NO')); // null
  /// print(bool.tryParse('YES')); // null
  /// print(bool.tryParse('0')); // null
  /// print(bool.tryParse('1')); // null
  /// ```
  static bool? tryParse(String source, {bool caseSensitive = true}) =>
      bool.tryParse(
        source,
        caseSensitive: caseSensitive,
      );

  /// The logical conjunction ("and") of this and [other].
  ///
  /// Returns `true` if both this and [other] are `true`, and `false` otherwise.
  static bool and(bool input, bool Function() other) => input & other();

  /// The logical disjunction ("inclusive or") of this and [other].
  ///
  /// Returns `true` if either this or [other] is `true`, and `false` otherwise.
  static bool inclusiveOr(bool input, bool Function() other) => input | other();

  /// The logical exclusive disjunction ("exclusive or") of this and [other].
  ///
  /// Returns whether this and [other] are neither both `true` nor both `false`.
  static bool exclusiveOr(bool input, bool other) => input ^ other;

  /// Returns either `"true"` for `true` and `"false"` for `false`.
  static String boolToString(
    bool input,
  ) =>
      input.toString();
}

/// Double Sugar
class SugarDouble {
  SugarDouble._();

  static double nan() => double.nan;

  static double infinity() => double.infinity;

  static double negativeInfinity() => double.negativeInfinity;

  static double minPositive() => double.minPositive;

  static double maxFinite() => double.maxFinite;

  /// The sign of the double's numerical value.
  ///
  /// Returns -1.0 if the value is less than zero,
  /// +1.0 if the value is greater than zero,
  /// and the value itself if it is -0.0, 0.0 or NaN.
  static double sign(double input) => input.sign;

  static double remainder(double input, num other) => input.remainder(
        other,
      );

  static double adds(double input, num other) => input + other;

  static double subtracts(double input, num other) => input - other;

  static double multiplies(double input, num other) => input * other;

  static double euclideanModulo(double input, num other) => input % other;

  static double divides(double input, num other) => input / other;

  static int truncatingDivision(double input, num other) => input ~/ other;

  static double negation(
    double input,
  ) =>
      -input;

  static double abs(
    double input,
  ) =>
      input.abs();

  /// Returns the integer closest to this number.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).round() == 4` and `(-3.5).round() == -4`.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or an infinity).
  /// ```dart
  /// print(3.0.round()); // 3
  /// print(3.25.round()); // 3
  /// print(3.5.round()); // 4
  /// print(3.75.round()); // 4
  /// print((-3.5).round()); // -4
  /// ```
  static int round(
    double input,
  ) =>
      input.round();

  /// Returns the greatest integer no greater than this number.
  ///
  /// Rounds the number towards negative infinity.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or infinity).
  /// ```dart
  /// print(1.99999.floor()); // 1
  /// print(2.0.floor()); // 2
  /// print(2.99999.floor()); // 2
  /// print((-1.99999).floor()); // -2
  /// print((-2.0).floor()); // -2
  /// print((-2.00001).floor()); // -3
  /// ```
  static int floor(
    double input,
  ) =>
      input.floor();

  /// Returns the least integer that is not smaller than this number.
  ///
  /// Rounds the number towards infinity.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or an infinity).
  /// ```dart
  /// print(1.99999.ceil()); // 2
  /// print(2.0.ceil()); // 2
  /// print(2.00001.ceil()); // 3
  /// print((-1.99999).ceil()); // -1
  /// print((-2.0).ceil()); // -2
  /// print((-2.00001).ceil()); // -2
  /// ```
  static int ceil(
    double input,
  ) =>
      input.ceil();

  /// Returns the integer obtained by discarding any fractional
  /// part of this number.
  ///
  /// Rounds the number towards zero.
  ///
  /// Throws an [UnsupportedError] if this number is not finite
  /// (NaN or an infinity).
  /// ```dart
  /// print(2.00001.truncate()); // 2
  /// print(1.99999.truncate()); // 1
  /// print(0.5.truncate()); // 0
  /// print((-0.5).truncate()); // 0
  /// print((-1.5).truncate()); // -1
  /// print((-2.5).truncate()); // -2
  /// ```
  static int truncate(
    double input,
  ) =>
      input.truncate();

  /// Returns the integer double value closest to `this`.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).roundToDouble() == 4` and `(-3.5).roundToDouble() == -4`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`,
  /// and `-0.0` is therefore considered closer to negative numbers than `0.0`.
  /// This means that for a value `d` in the range `-0.5 < d < 0.0`,
  /// the result is `-0.0`.
  /// ```dart
  /// print(3.0.roundToDouble()); // 3.0
  /// print(3.25.roundToDouble()); // 3.0
  /// print(3.5.roundToDouble()); // 4.0
  /// print(3.75.roundToDouble()); // 4.0
  /// print((-3.5).roundToDouble()); // -4.0
  /// ```
  static double roundToDouble(
    double input,
  ) =>
      input.roundToDouble();

  /// Returns the greatest integer double value no greater than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `0.0 < d < 1.0` will return `0.0`.
  /// ```dart
  /// print(1.99999.floorToDouble()); // 1.0
  /// print(2.0.floorToDouble()); // 2.0
  /// print(2.99999.floorToDouble()); // 2.0
  /// print((-1.99999).floorToDouble()); // -2.0
  /// print((-2.0).floorToDouble()); // -2.0
  /// print((-2.00001).floorToDouble()); // -3.0
  /// ```
  static double floorToDouble(
    double input,
  ) =>
      input.floorToDouble();

  /// Returns the least integer double value no smaller than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`.
  /// ```dart
  /// print(1.99999.ceilToDouble()); // 2.0
  /// print(2.0.ceilToDouble()); // 2.0
  /// print(2.00001.ceilToDouble()); // 3.0
  /// print((-1.99999).ceilToDouble()); // -1.0
  /// print((-2.0).ceilToDouble()); // -2.0
  /// print((-2.00001).ceilToDouble()); // -2.0
  /// ```
  static double ceilToDouble(
    double input,
  ) =>
      input.ceilToDouble();

  /// Returns the integer double value obtained by discarding any fractional
  /// digits from `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is not
  /// a finite value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`, and
  /// in the range `0.0 < d < 1.0` it will return 0.0.
  /// ```dart
  /// print(2.5.truncateToDouble()); // 2.0
  /// print(2.00001.truncateToDouble()); // 2.0
  /// print(1.99999.truncateToDouble()); // 1.0
  /// print(0.5.truncateToDouble()); // 0.0
  /// print((-0.5).truncateToDouble()); // -0.0
  /// print((-1.5).truncateToDouble()); // -1.0
  /// print((-2.5).truncateToDouble()); // -2.0
  /// ```
  static double truncateToDouble(
    double input,
  ) =>
      input.truncateToDouble();

  /// Provide a representation of this [double] value.
  ///
  /// The representation is a number literal such that the closest double value
  /// to the representation's mathematical value is this [double].
  ///
  /// Returns "NaN" for the Not-a-Number value.
  /// Returns "Infinity" and "-Infinity" for positive and negative Infinity.
  /// Returns "-0.0" for negative zero.
  ///
  /// For all doubles, `d`, converting to a string and parsing the string back
  /// gives the same value again: `d == double.parse(d.toString())` (except when
  /// `d` is NaN).
  static String doubleToString(
    double input,
  ) =>
      input.toString();

  /// Parse [source] as a double literal and return its value.
  ///
  /// Accepts an optional sign (`+` or `-`) followed by either the characters
  /// "Infinity", the characters "NaN" or a floating-point representation.
  /// A floating-point representation is composed of a mantissa and an optional
  /// exponent part. The mantissa is either a decimal point (`.`) followed by a
  /// sequence of (decimal) digits, or a sequence of digits
  /// optionally followed by a decimal point and optionally more digits. The
  /// (optional) exponent part consists of the character "e" or "E", an optional
  /// sign, and one or more digits.
  /// The [source] must not be `null`.
  ///
  /// Leading and trailing whitespace is ignored.
  ///
  /// Throws a [FormatException] if the [source] string is not
  /// a valid double literal.
  ///
  /// Rather than throwing and immediately catching the [FormatException],
  /// instead use [tryParse] to handle a potential parsing error.
  ///
  /// Examples of accepted strings:
  /// ```
  /// "3.14"
  /// "  3.14 \xA0"
  /// "0."
  /// ".0"
  /// "-1.e3"
  /// "1234E+7"
  /// "+.12e-9"
  /// "-NaN"
  /// ```
  static double parse(String source) => double.parse(
        source,
      );

  /// Parse [source] as a double literal and return its value.
  ///
  /// Like [parse], except that this function returns `null` for invalid inputs
  /// instead of throwing.
  ///
  /// Example:
  /// ```dart
  /// var value = double.tryParse('3.14'); // 3.14
  /// value = double.tryParse('  3.14 \xA0'); // 3.14
  /// value = double.tryParse('0.'); // 0.0
  /// value = double.tryParse('.0'); // 0.0
  /// value = double.tryParse('-1.e3'); // -1000.0
  /// value = double.tryParse('1234E+7'); // 12340000000.0
  /// value = double.tryParse('+.12e-9'); // 1.2e-10
  /// value = double.tryParse('-NaN'); // NaN
  /// value = double.tryParse('0xFF'); // null
  /// value = double.tryParse(double.infinity.toString()); // Infinity
  /// ```
  static double? tryParse(String source) => double.tryParse(
        source,
      );
}

/// Int Sugar
class SugarInt {
  SugarInt._();

  /// Returns true if and only if this integer is even.
  static bool isEven(int input) => input.isEven;

  /// Returns true if and only if this integer is odd.
  static bool isOdd(int input) => input.isOdd;

  /// Returns the minimum number of bits required to store this integer.
  ///
  /// The number of bits excludes the sign bit, which gives the natural length
  /// for non-negative (unsigned) values.  Negative values are complemented to
  /// return the bit position of the first bit that differs from the sign bit.
  ///
  /// To find the number of bits needed to store the value as a signed value,
  /// add one, i.e. use `x.bitLength + 1`.
  /// ```dart
  /// x.bitLength == (-x-1).bitLength;
  ///
  /// 3.bitLength == 2;     // 00000011
  /// 2.bitLength == 2;     // 00000010
  /// 1.bitLength == 1;     // 00000001
  /// 0.bitLength == 0;     // 00000000
  /// (-1).bitLength == 0;  // 11111111
  /// (-2).bitLength == 1;  // 11111110
  /// (-3).bitLength == 2;  // 11111101
  /// (-4).bitLength == 2;  // 11111100
  /// ```
  static int bitLength(int input) => input.bitLength;

  /// Returns the sign of this integer.
  ///
  /// Returns 0 for zero, -1 for values less than zero and
  /// +1 for values greater than zero.
  static int sign(int input) => input.sign;

  /// Bit-wise and operator.
  ///
  /// Treating both `this` and [other] as sufficiently large two's component
  /// integers, the result is a number with only the bits set that are set in
  /// both `this` and [other]
  ///
  /// If both operands are negative, the result is negative, otherwise
  /// the result is non-negative.
  /// ```dart
  /// print((2 & 1).toRadixString(2)); // 0010 & 0001 -> 0000
  /// print((3 & 1).toRadixString(2)); // 0011 & 0001 -> 0001
  /// print((10 & 2).toRadixString(2)); // 1010 & 0010 -> 0010
  /// ```
  static int and(int input, int other) => input & other;

  /// Bit-wise or operator.
  ///
  /// Treating both `this` and [other] as sufficiently large two's component
  /// integers, the result is a number with the bits set that are set in either
  /// of `this` and [other]
  ///
  /// If both operands are non-negative, the result is non-negative,
  /// otherwise the result is negative.
  ///
  /// Example:
  /// ```dart
  /// print((2 | 1).toRadixString(2)); // 0010 | 0001 -> 0011
  /// print((3 | 1).toRadixString(2)); // 0011 | 0001 -> 0011
  /// print((10 | 2).toRadixString(2)); // 1010 | 0010 -> 1010
  /// ```
  static int or(int input, int other) => input | other;

  /// Bit-wise exclusive-or operator.
  ///
  /// Treating both `this` and [other] as sufficiently large two's component
  /// integers, the result is a number with the bits set that are set in one,
  /// but not both, of `this` and [other]
  ///
  /// If the operands have the same sign, the result is non-negative,
  /// otherwise the result is negative.
  ///
  /// Example:
  /// ```dart
  /// print((2 ^ 1).toRadixString(2)); //  0010 ^ 0001 -> 0011
  /// print((3 ^ 1).toRadixString(2)); //  0011 ^ 0001 -> 0010
  /// print((10 ^ 2).toRadixString(2)); //  1010 ^ 0010 -> 1000
  /// ```
  static int exclusiveOr(int input, int other) => input ^ other;

  /// The bit-wise negate operator.
  ///
  /// Treating `this` as a sufficiently large two's component integer,
  /// the result is a number with the opposite bits set.
  ///
  /// This maps any integer `x` to `-x - 1`.
  static int negate(
    int input,
  ) =>
      ~input;

  /// Shift the bits of this integer to the left by [shiftAmount].
  ///
  /// Shifting to the left makes the number larger, effectively multiplying
  /// the number by `pow(2, shiftAmount)`.
  ///
  /// There is no limit on the size of the result. It may be relevant to
  /// limit intermediate values by using the "and" operator with a suitable
  /// mask.
  ///
  /// It is an error if [shiftAmount] is negative.
  ///
  /// Example:
  /// ```dart
  /// print((3 << 1).toRadixString(2)); // 0011 -> 0110
  /// print((9 << 2).toRadixString(2)); // 1001 -> 100100
  /// print((10 << 3).toRadixString(2)); // 1010 -> 1010000
  /// ```
  static int leftShift(int input, int shiftAmount) => input << shiftAmount;

  /// Shift the bits of this integer to the right by [shiftAmount].
  ///
  /// Shifting to the right makes the number smaller and drops the least
  /// significant bits, effectively doing an integer division by
  /// `pow(2, shiftAmount)`.
  ///
  /// It is an error if [shiftAmount] is negative.
  ///
  /// Example:
  /// ```dart
  /// print((3 >> 1).toRadixString(2)); // 0011 -> 0001
  /// print((9 >> 2).toRadixString(2)); // 1001 -> 0010
  /// print((10 >> 3).toRadixString(2)); // 1010 -> 0001
  /// print((-6 >> 2).toRadixString); // 111...1010 -> 111...1110 == -2
  /// print((-85 >> 3).toRadixString); // 111...10101011 -> 111...11110101 == -11
  /// ```
  static int rightShift(int input, int shiftAmount) => input >> shiftAmount;

  /// Bitwise unsigned right shift by [shiftAmount] bits.
  ///
  /// The least significant [shiftAmount] bits are dropped,
  /// the remaining bits (if any) are shifted down,
  /// and zero-bits are shifted in as the new most significant bits.
  ///
  /// The [shiftAmount] must be non-negative.
  ///
  /// Example:
  /// ```dart
  /// print((3 >>> 1).toRadixString(2)); // 0011 -> 0001
  /// print((9 >>> 2).toRadixString(2)); // 1001 -> 0010
  /// print(((-9) >>> 2).toRadixString(2)); // 111...1011 -> 001...1110 (> 0)
  /// ```
  static int unsignedRightShift(int input, int shiftAmount) =>
      input >>> shiftAmount;

  /// Returns this integer to the power of [exponent] modulo [modulus].
  ///
  /// The [exponent] must be non-negative and [modulus] must be
  /// positive.
  static int modPow(int input, int exponent, int modulus) => input.modPow(
        exponent,
        modulus,
      );

  /// Returns the modular multiplicative inverse of this integer
  /// modulo [modulus].
  ///
  /// The [modulus] must be positive.
  ///
  /// It is an error if no modular inverse exists.
  static int modInverse(int input, int modulus) => input.modInverse(
        modulus,
      );

  /// Returns the greatest common divisor of this integer and [other].
  ///
  /// If either number is non-zero, the result is the numerically greatest
  /// integer dividing both `this` and `other`.
  ///
  /// The greatest common divisor is independent of the order,
  /// so `x.gcd(y)` is  always the same as `y.gcd(x)`.
  ///
  /// For any integer `x`, `x.gcd(x)` is `x.abs()`.
  ///
  /// If both `this` and `other` is zero, the result is also zero.
  ///
  /// Example:
  /// ```dart
  /// print(4.gcd(2)); // 2
  /// print(8.gcd(4)); // 4
  /// print(10.gcd(12)); // 2
  /// print(10.gcd(0)); // 10
  /// print((-2).gcd(-3)); // 1
  /// ```
  static int gcd(int input, int other) => input.gcd(
        other,
      );

  /// Returns the least significant [width] bits of this integer as a
  /// non-negative number (i.e. unsigned representation).  The returned value has
  /// zeros in all bit positions higher than [width].
  /// ```dart
  /// (-1).toUnsigned(5) == 31   // 11111111  ->  00011111
  /// ```
  /// This operation can be used to simulate arithmetic from low level languages.
  /// For example, to increment an 8 bit quantity:
  /// ```dart
  /// q = (q + 1).toUnsigned(8);
  /// ```
  /// `q` will count from `0` up to `255` and then wrap around to `0`.
  ///
  /// If the input fits in [width] bits without truncation, the result is the
  /// same as the input.  The minimum width needed to avoid truncation of `x` is
  /// given by `x.bitLength`, i.e.
  /// ```dart
  /// x == x.toUnsigned(x.bitLength);
  /// ```
  static int toUnsigned(int input, int width) => input.toUnsigned(
        width,
      );

  /// Returns the least significant [width] bits of this integer, extending the
  /// highest retained bit to the sign. This is the same as truncating the value
  /// to fit in [width] bits using an signed 2-s complement representation. The
  /// returned value has the same bit value in all positions higher than [width].
  ///
  /// ```dart
  ///                          //     V--sign bit-V
  /// 16.toSigned(5) == -16;   //  00010000 -> 11110000
  /// 239.toSigned(5) == 15;   //  11101111 -> 00001111
  ///                          //     ^           ^
  /// ```
  /// This operation can be used to simulate arithmetic from low level languages.
  /// For example, to increment an 8 bit signed quantity:
  /// ```dart
  /// q = (q + 1).toSigned(8);
  /// ```
  /// `q` will count from `0` up to `127`, wrap to `-128` and count back up to
  /// `127`.
  ///
  /// If the input value fits in [width] bits without truncation, the result is
  /// the same as the input.  The minimum width needed to avoid truncation of `x`
  /// is `x.bitLength + 1`, i.e.
  /// ```dart
  /// x == x.toSigned(x.bitLength + 1);
  /// ```
  static int toSigned(int input, int width) => input.toSigned(
        width,
      );

  /// Return the negative value of this integer.
  ///
  /// The result of negating an integer always has the opposite sign, except
  /// for zero, which is its own negation.
  static int negation(
    int input,
  ) =>
      -input;

  /// Returns the absolute value of this integer.
  ///
  /// For any integer `value`,
  /// the result is the same as `value < 0 ? -value : value`.
  ///
  /// Integer overflow may cause the result of `-value` to stay negative.
  static int abs(
    int input,
  ) =>
      input.abs();

  /// Returns `this`.
  static int round(
    int input,
  ) =>
      input.round();

  /// Returns `this`.
  static int floor(
    int input,
  ) =>
      input.floor();

  /// Returns `this`.
  static int ceil(
    int input,
  ) =>
      input.ceil();

  /// Returns `this`.
  static int truncate(
    int input,
  ) =>
      input.truncate();

  /// Returns `this.toDouble()`.
  static double roundToDouble(
    int input,
  ) =>
      input.roundToDouble();

  /// Returns `this.toDouble()`.
  static double floorToDouble(
    int input,
  ) =>
      input.floorToDouble();

  /// Returns `this.toDouble()`.
  static double ceilToDouble(
    int input,
  ) =>
      input.ceilToDouble();

  /// Returns `this.toDouble()`.
  static double truncateToDouble(
    int input,
  ) =>
      input.truncateToDouble();

  /// Returns a string representation of this integer.
  ///
  /// The returned string is parsable by [parse].
  /// For any `int` `i`, it is guaranteed that
  /// `i == int.parse(i.toString())`.
  static String intToString(
    int input,
  ) =>
      input.toString();

  /// Converts [this] to a string representation in the given [radix].
  ///
  /// In the string representation, lower-case letters are used for digits above
  /// '9', with 'a' being 10 and 'z' being 35.
  ///
  /// The [radix] argument must be an integer in the range 2 to 36.
  ///
  /// Example:
  /// ```dart
  /// // Binary (base 2).
  /// print(12.toRadixString(2)); // 1100
  /// print(31.toRadixString(2)); // 11111
  /// print(2021.toRadixString(2)); // 11111100101
  /// print((-12).toRadixString(2)); // -1100
  /// // Octal (base 8).
  /// print(12.toRadixString(8)); // 14
  /// print(31.toRadixString(8)); // 37
  /// print(2021.toRadixString(8)); // 3745
  /// // Hexadecimal (base 16).
  /// print(12.toRadixString(16)); // c
  /// print(31.toRadixString(16)); // 1f
  /// print(2021.toRadixString(16)); // 7e5
  /// // Base 36.
  /// print((35 * 36 + 1).toRadixString(36)); // z1
  /// ```
  static String toRadixString(int input, int radix) => input.toRadixString(
        radix,
      );

  /// Parse [source] as a, possibly signed, integer literal and return its value.
  ///
  /// The [source] must be a non-empty sequence of base-[radix] digits,
  /// optionally prefixed with a minus or plus sign ('-' or '+').
  ///
  /// The [radix] must be in the range 2..36. The digits used are
  /// first the decimal digits 0..9, and then the letters 'a'..'z' with
  /// values 10 through 35. Also accepts upper-case letters with the same
  /// values as the lower-case ones.
  ///
  /// If no [radix] is given then it defaults to 10. In this case, the [source]
  /// digits may also start with `0x`, in which case the number is interpreted
  /// as a hexadecimal integer literal,
  /// When `int` is implemented by 64-bit signed integers,
  /// hexadecimal integer literals may represent values larger than
  /// 2<sup>63</sup>, in which case the value is parsed as if it is an
  /// *unsigned* number, and the resulting value is the corresponding
  /// signed integer value.
  ///
  /// For any int `n` and valid radix `r`, it is guaranteed that
  /// `n == int.parse(n.toRadixString(r), radix: r)`.
  ///
  /// If the [source] string does not contain a valid integer literal,
  /// optionally prefixed by a sign, a [FormatException] is thrown.
  ///
  /// Rather than throwing and immediately catching the [FormatException],
  /// instead use [tryParse] to handle a potential parsing error.
  ///
  /// Example:
  /// ```dart
  /// var value = int.tryParse(text);
  /// if (value == null) {
  ///   // handle the problem
  ///   // ...
  /// }
  /// ```
  static int parse(String source, {int? radix}) => int.parse(
        source,
        radix: radix,
      );

  /// Parse [source] as a, possibly signed, integer literal.
  ///
  /// Like [parse] except that this function returns `null` where a
  /// similar call to [parse] would throw a [FormatException].
  ///
  /// Example:
  /// ```dart
  /// print(int.tryParse('2021')); // 2021
  /// print(int.tryParse('1f')); // null
  /// // From binary (base 2) value.
  /// print(int.tryParse('1100', radix: 2)); // 12
  /// print(int.tryParse('00011111', radix: 2)); // 31
  /// print(int.tryParse('011111100101', radix: 2)); // 2021
  /// // From octal (base 8) value.
  /// print(int.tryParse('14', radix: 8)); // 12
  /// print(int.tryParse('37', radix: 8)); // 31
  /// print(int.tryParse('3745', radix: 8)); // 2021
  /// // From hexadecimal (base 16) value.
  /// print(int.tryParse('c', radix: 16)); // 12
  /// print(int.tryParse('1f', radix: 16)); // 31
  /// print(int.tryParse('7e5', radix: 16)); // 2021
  /// // From base 35 value.
  /// print(int.tryParse('y1', radix: 35)); // 1191 == 34 * 35 + 1
  /// print(int.tryParse('z1', radix: 35)); // null
  /// // From base 36 value.
  /// print(int.tryParse('y1', radix: 36)); // 1225 == 34 * 36 + 1
  /// print(int.tryParse('z1', radix: 36)); // 1261 == 35 * 36 + 1
  /// ```
  static int? tryParse(String source, {int? radix}) => int.tryParse(
        source,
        radix: radix,
      );
}

/// List Sugar
class SugarList {
  SugarList._();

  /// Creates a list of the given length with [fill] at each position.
  ///
  /// The [length] must be a non-negative integer.
  ///
  /// Example:
  /// ```dart
  /// final zeroList = List<int>.filled(3, 0, growable: true); // [0, 0, 0]
  /// ```
  ///
  /// The created list is fixed-length if [growable] is false (the default)
  /// and growable if [growable] is true.
  /// If the list is growable, increasing its [length] will *not* initialize
  /// new entries with [fill].
  /// After being created and filled, the list is no different from any other
  /// growable or fixed-length list created
  /// using `[]` or other [List] constructors.
  ///
  /// All elements of the created list share the same [fill] value.
  /// ```dart
  /// final shared = List.filled(3, []);
  /// shared[0].add(499);
  /// print(shared);  // [[499], [499], [499]]
  /// ```
  /// You can use [List.generate] to create a list with a fixed length
  /// and a new object at each position.
  /// ```dart
  /// final unique = List.generate(3, (_) => []);
  /// unique[0].add(499);
  /// print(unique); // [[499], [], []]
  /// ```
  static List<dynamic> filled(int length, dynamic fill,
          {bool growable = false}) =>
      List.filled(
        length,
        fill,
        growable: growable,
      );

  /// Creates a new empty list.
  ///
  /// If [growable] is `false`, which is the default,
  /// the list is a fixed-length list of length zero.
  /// If [growable] is `true`, the list is growable and equivalent to `<E>[]`.
  /// ```dart
  /// final growableList = List.empty(growable: true); // []
  /// growableList.add(1); // [1]
  ///
  /// final fixedLengthList = List.empty(growable: false);
  /// fixedLengthList.add(1); // error
  /// ```
  static List<dynamic> empty({bool growable = false}) => List.empty(
        growable: growable,
      );

  /// Creates a list containing all [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// All the [elements] should be instances of [E].
  ///
  /// Example:
  /// ```dart
  /// final numbers = <num>[1, 2, 3];
  /// final listFrom = List<int>.from(numbers);
  /// print(listFrom); // [1, 2, 3]
  /// ```
  /// The `elements` iterable itself may have any element type, so this
  /// constructor can be used to down-cast a `List`, for example as:
  /// ```dart import:convert
  /// const jsonArray = '''
  ///   [{"text": "foo", "value": 1, "status": true},
  ///    {"text": "bar", "value": 2, "status": false}]
  /// ''';
  /// final List<dynamic> dynamicList = jsonDecode(jsonArray);
  /// final List<Map<String, dynamic>> fooData =
  ///     List.from(dynamicList.where((x) => x is Map && x['text'] == 'foo'));
  /// print(fooData); // [{text: foo, value: 1, status: true}]
  /// ```
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  static List<dynamic> from(Iterable<dynamic> elements,
          {bool growable = true}) =>
      List.from(
        elements,
        growable: growable,
      );

  /// Creates a list from [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// This constructor creates a growable list when [growable] is true;
  /// otherwise, it returns a fixed-length list.
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// final listOf = List<num>.of(numbers);
  /// print(listOf); // [1, 2, 3]
  /// ```
  static List<dynamic> of(Iterable<dynamic> elements, {bool growable = true}) =>
      List.of(
        elements,
        growable: growable,
      );

  /// Generates a list of values.
  ///
  /// Creates a list with [length] positions and fills it with values created by
  /// calling [generator] for each index in the range `0` .. `length - 1`
  /// in increasing order.
  /// ```dart
  /// final growableList =
  ///     List<int>.generate(3, (int index) => index * index, growable: true);
  /// print(growableList); // [0, 1, 4]
  ///
  /// final fixedLengthList =
  ///     List<int>.generate(3, (int index) => index * index, growable: false);
  /// print(fixedLengthList); // [0, 1, 4]
  /// ```
  /// The created list is fixed-length if [growable] is set to false.
  ///
  /// The [length] must be non-negative.
  static List<dynamic> generate(int length, dynamic Function(int) generator,
          {bool growable = true}) =>
      List.generate(
        length,
        generator,
        growable: growable,
      );

  /// Creates an unmodifiable list containing all [elements].
  ///
  /// The [Iterator] of [elements] provides the order of the elements.
  ///
  /// An unmodifiable list cannot have its length or elements changed.
  /// If the elements are themselves immutable, then the resulting list
  /// is also immutable.
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// final unmodifiableList = List.unmodifiable(numbers); // [1, 2, 3]
  /// unmodifiableList[1] = 87; // Throws.
  /// ```
  static List<dynamic> unmodifiable(Iterable<dynamic> elements) =>
      List.unmodifiable(
        elements,
      );

  /// The number of objects in this list.
  ///
  /// The valid indices for a list are `0` through `length - 1`.
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// print(numbers.length); // 3
  /// ```
  static int length(List input) => input.length;

  /// An [Iterable] of the objects in this list in reverse order.
  /// ```dart
  /// final numbers = <String>['two', 'three', 'four'];
  /// final reverseOrder = numbers.reversed;
  /// print(reverseOrder.toList()); // [four, three, two]
  /// ```
  static Iterable<dynamic> reversed(List input) => input.reversed;

  /// Adapts [source] to be a `List<T>`.
  ///
  /// Any time the list would produce an element that is not a [T],
  /// the element access will throw.
  ///
  /// Any time a [T] value is attempted stored into the adapted list,
  /// the store will throw unless the value is also an instance of [S].
  ///
  /// If all accessed elements of [source] are actually instances of [T],
  /// and if all elements stored into the returned list are actually instance
  /// of [S],
  /// then the returned list can be used as a `List<T>`.
  ///
  /// Methods which accept `Object?` as argument, like [contains] and [remove],
  /// will pass the argument directly to the this list's method
  /// without any checks.
  static List<T> castFrom<S, T>(List<S> source) => List.castFrom(
        source,
      );

  /// Copy a range of one list into another list.
  ///
  /// This is a utility function that can be used to implement methods like
  /// [setRange].
  ///
  /// The range from [start] to [end] must be a valid range of [source],
  /// and there must be room for `end - start` elements from position [at].
  /// If [start] is omitted, it defaults to zero.
  /// If [end] is omitted, it defaults to [source].length.
  ///
  /// If [source] and [target] are the same list, overlapping source and target
  /// ranges are respected so that the target range ends up containing the
  /// initial content of the source range.
  /// Otherwise the order of element copying is not guaranteed.
  static void copyRange<T>(List<T> target, int at, List<T> source,
          [int? start, int? end]) =>
      List.copyRange(
        target,
        at,
        source,
        start,
        end,
      );

  /// Write the elements of an iterable into a list.
  ///
  /// This is a utility function that can be used to implement methods like
  /// [setAll].
  ///
  /// The elements of [source] are written into [target] from position [at].
  /// The [source] must not contain more elements after writing the last
  /// position of [target].
  ///
  /// If the source is a list, the [copyRange] function is likely to be more
  /// efficient.
  static void writeIterable<T>(List<T> target, int at, Iterable<T> source) =>
      List.writeIterable(
        target,
        at,
        source,
      );

  /// Returns a view of this list as a list of [R] instances.
  ///
  /// If this list contains only instances of [R], all read operations
  /// will work correctly. If any operation tries to read an element
  /// that is not an instance of [R], the access will throw instead.
  ///
  /// Elements added to the list (e.g., by using [add] or [addAll])
  /// must be instances of [R] to be valid arguments to the adding function,
  /// and they must also be instances of [E] to be accepted by
  /// this list as well.
  ///
  /// Methods which accept `Object?` as argument, like [contains] and [remove],
  /// will pass the argument directly to the this list's method
  /// without any checks.
  /// That means that you can do `listOfStrings.cast<int>().remove("a")`
  /// successfully, even if it looks like it shouldn't have any effect.
  ///
  /// Typically implemented as `List.castFrom<E, R>(this)`.
  static List<R> cast<R>(
    List input,
  ) =>
      input.cast();

  /// The object at the given [index] in the list.
  ///
  /// The [index] must be a valid index of this list,
  /// which means that `index` must be non-negative and
  /// less than [length].
  static dynamic get(List input, int index) => input[index];

  /// Sets the value at the given [index] in the list to [value].
  ///
  /// The [index] must be a valid index of this list,
  /// which means that `index` must be non-negative and
  /// less than [length].
  static void set(List input, int index, dynamic value) => input[index] = value;

  /// Adds [value] to the end of this list,
  /// extending the length by one.
  ///
  /// The list must be growable.
  ///
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// numbers.add(4);
  /// print(numbers); // [1, 2, 3, 4]
  /// ```
  static void add(List input, dynamic value) => input.add(
        value,
      );

  /// Appends all objects of [iterable] to the end of this list.
  ///
  /// Extends the length of the list by the number of objects in [iterable].
  /// The list must be growable.
  ///
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// numbers.addAll([4, 5, 6]);
  /// print(numbers); // [1, 2, 3, 4, 5, 6]
  /// ```
  static void addAll(List input, Iterable<dynamic> iterable) => input.addAll(
        iterable,
      );

  /// Sorts this list according to the order specified by the [compare] function.
  ///
  /// The [compare] function must act as a [Comparator].
  /// ```dart
  /// final numbers = <String>['two', 'three', 'four'];
  /// // Sort from shortest to longest.
  /// numbers.sort((a, b) => a.length.compareTo(b.length));
  /// print(numbers); // [two, four, three]
  /// ```
  /// The default [List] implementations use [Comparable.compare] if
  /// [compare] is omitted.
  /// ```dart
  /// final numbers = <int>[13, 2, -11, 0];
  /// numbers.sort();
  /// print(numbers); // [-11, 0, 2, 13]
  /// ```
  /// In that case, the elements of the list must be [Comparable] to
  /// each other.
  ///
  /// A [Comparator] may compare objects as equal (return zero), even if they
  /// are distinct objects.
  /// The sort function is not guaranteed to be stable, so distinct objects
  /// that compare as equal may occur in any order in the result:
  /// ```dart
  /// final numbers = <String>['one', 'two', 'three', 'four'];
  /// numbers.sort((a, b) => a.length.compareTo(b.length));
  /// print(numbers); // [one, two, four, three] OR [two, one, four, three]
  /// ```
  static void sort(List input, [int Function(dynamic, dynamic)? compare]) =>
      input.sort(
        compare,
      );

  /// Shuffles the elements of this list randomly.
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4, 5];
  /// numbers.shuffle();
  /// print(numbers); // [1, 3, 4, 5, 2] OR some other random result.
  /// ```
  static void shuffle(List input, [Random? random]) => input.shuffle(
        random,
      );

  /// The first index of [element] in this list.
  ///
  /// Searches the list from index [start] to the end of the list.
  /// The first time an object `o` is encountered so that `o == element`,
  /// the index of `o` is returned.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// print(notes.indexOf('re')); // 1
  ///
  /// final indexWithStart = notes.indexOf('re', 2); // 3
  /// ```
  /// Returns -1 if [element] is not found.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final index = notes.indexOf('fa'); // -1
  /// ```
  static int indexOf(List input, dynamic element, [int start = 0]) =>
      input.indexOf(
        element,
        start,
      );

  /// The first index in the list that satisfies the provided [test].
  ///
  /// Searches the list from index [start] to the end of the list.
  /// The first time an object `o` is encountered so that `test(o)` is true,
  /// the index of `o` is returned.
  ///
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final first = notes.indexWhere((note) => note.startsWith('r')); // 1
  /// final second = notes.indexWhere((note) => note.startsWith('r'), 2); // 3
  /// ```
  ///
  /// Returns -1 if [element] is not found.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final index = notes.indexWhere((note) => note.startsWith('k')); // -1
  /// ```
  static int indexWhere(List input, bool Function(dynamic) test,
          [int start = 0]) =>
      input.indexWhere(
        test,
        start,
      );

  /// The last index in the list that satisfies the provided [test].
  ///
  /// Searches the list from index [start] to 0.
  /// The first time an object `o` is encountered so that `test(o)` is true,
  /// the index of `o` is returned.
  /// If [start] is omitted, it defaults to the [length] of the list.
  ///
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final first = notes.lastIndexWhere((note) => note.startsWith('r')); // 3
  /// final second = notes.lastIndexWhere((note) => note.startsWith('r'),
  ///     2); // 1
  /// ```
  ///
  /// Returns -1 if [element] is not found.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final index = notes.lastIndexWhere((note) => note.startsWith('k'));
  /// print(index); // -1
  /// ```
  static int lastIndexWhere(List input, bool Function(dynamic) test,
          [int? start]) =>
      input.lastIndexWhere(
        test,
        start,
      );

  /// The last index of [element] in this list.
  ///
  /// Searches the list backwards from index [start] to 0.
  ///
  /// The first time an object `o` is encountered so that `o == element`,
  /// the index of `o` is returned.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// const startIndex = 2;
  /// final index = notes.lastIndexOf('re', startIndex); // 1
  /// ```
  /// If [start] is not provided, this method searches from the end of the
  /// list.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final index = notes.lastIndexOf('re'); // 3
  /// ```
  /// Returns -1 if [element] is not found.
  /// ```dart
  /// final notes = <String>['do', 're', 'mi', 're'];
  /// final index = notes.lastIndexOf('fa'); // -1
  /// ```
  static int lastIndexOf(List input, dynamic element, [int? start]) =>
      input.lastIndexOf(
        element,
        start,
      );

  /// Removes all objects from this list; the length of the list becomes zero.
  ///
  /// The list must be growable.
  ///
  /// ```dart
  /// final numbers = <int>[1, 2, 3];
  /// numbers.clear();
  /// print(numbers.length); // 0
  /// print(numbers); // []
  /// ```
  static void clear(
    List input,
  ) =>
      input.clear();

  /// Inserts [element] at position [index] in this list.
  ///
  /// This increases the length of the list by one and shifts all objects
  /// at or after the index towards the end of the list.
  ///
  /// The list must be growable.
  /// The [index] value must be non-negative and no greater than [length].
  ///
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4];
  /// const index = 2;
  /// numbers.insert(index, 10);
  /// print(numbers); // [1, 2, 10, 3, 4]
  /// ```
  static void insert(List input, int index, dynamic element) => input.insert(
        index,
        element,
      );

  /// Inserts all objects of [iterable] at position [index] in this list.
  ///
  /// This increases the length of the list by the length of [iterable] and
  /// shifts all later objects towards the end of the list.
  ///
  /// The list must be growable.
  /// The [index] value must be non-negative and no greater than [length].
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4];
  /// final insertItems = [10, 11];
  /// numbers.insertAll(2, insertItems);
  /// print(numbers); // [1, 2, 10, 11, 3, 4]
  /// ```
  static void insertAll(List input, int index, Iterable<dynamic> iterable) =>
      input.insertAll(
        index,
        iterable,
      );

  /// Overwrites elements with the objects of [iterable].
  ///
  /// The elements of [iterable] are written into this list,
  /// starting at position [index].
  /// This operation does not increase the length of the list.
  ///
  /// The [index] must be non-negative and no greater than [length].
  ///
  /// The [iterable] must not have more elements than what can fit from [index]
  /// to [length].
  ///
  /// If `iterable` is based on this list, its values may change _during_ the
  /// `setAll` operation.
  /// ```dart
  /// final list = <String>['a', 'b', 'c', 'd'];
  /// list.setAll(1, ['bee', 'sea']);
  /// print(list); // [a, bee, sea, d]
  /// ```
  static void setAll(List input, int index, Iterable<dynamic> iterable) =>
      input.setAll(
        index,
        iterable,
      );

  /// Removes the first occurrence of [value] from this list.
  ///
  /// Returns true if [value] was in the list, false otherwise.
  /// The list must be growable.
  ///
  /// ```dart
  /// final parts = <String>['head', 'shoulders', 'knees', 'toes'];
  /// final retVal = parts.remove('head'); // true
  /// print(parts); // [shoulders, knees, toes]
  /// ```
  /// The method has no effect if [value] was not in the list.
  /// ```dart
  /// final parts = <String>['shoulders', 'knees', 'toes'];
  /// // Note: 'head' has already been removed.
  /// final retVal = parts.remove('head'); // false
  /// print(parts); // [shoulders, knees, toes]
  /// ```
  static bool remove(List input, Object? value) => input.remove(
        value,
      );

  /// Removes the object at position [index] from this list.
  ///
  /// This method reduces the length of `this` by one and moves all later objects
  /// down by one position.
  ///
  /// Returns the removed value.
  ///
  /// The [index] must be in the range `0 ≤ index < length`.
  /// The list must be growable.
  /// ```dart
  /// final parts = <String>['head', 'shoulder', 'knees', 'toes'];
  /// final retVal = parts.removeAt(2); // knees
  /// print(parts); // [head, shoulder, toes]
  /// ```
  static dynamic removeAt(List input, int index) => input.removeAt(
        index,
      );

  /// Removes and returns the last object in this list.
  ///
  /// The list must be growable and non-empty.
  /// ```dart
  /// final parts = <String>['head', 'shoulder', 'knees', 'toes'];
  /// final retVal = parts.removeLast(); // toes
  /// print(parts); // [head, shoulder, knees]
  /// ```
  static dynamic removeLast(
    List input,
  ) =>
      input.removeLast();

  /// Removes all objects from this list that satisfy [test].
  ///
  /// An object `o` satisfies [test] if `test(o)` is true.
  /// ```dart
  /// final numbers = <String>['one', 'two', 'three', 'four'];
  /// numbers.removeWhere((item) => item.length == 3);
  /// print(numbers); // [three, four]
  /// ```
  /// The list must be growable.
  static void removeWhere(List input, bool Function(dynamic) test) =>
      input.removeWhere(
        test,
      );

  /// Removes all objects from this list that fail to satisfy [test].
  ///
  /// An object `o` satisfies [test] if `test(o)` is true.
  /// ```dart
  /// final numbers = <String>['one', 'two', 'three', 'four'];
  /// numbers.retainWhere((item) => item.length == 3);
  /// print(numbers); // [one, two]
  /// ```
  /// The list must be growable.
  static void retainWhere(List input, bool Function(dynamic) test) =>
      input.retainWhere(
        test,
      );

  /// Returns the concatenation of this list and [other].
  ///
  /// Returns a new list containing the elements of this list followed by
  /// the elements of [other].
  ///
  /// The default behavior is to return a normal growable list.
  /// Some list types may choose to return a list of the same type as themselves
  /// (see [Uint8List.+]);
  static List<dynamic> adds(List input, List<dynamic> other) => input + other;

  /// Returns a new list containing the elements between [start] and [end].
  ///
  /// The new list is a `List<E>` containing the elements of this list at
  /// positions greater than or equal to [start] and less than [end] in the same
  /// order as they occur in this list.
  ///
  /// ```dart
  /// final colors = <String>['red', 'green', 'blue', 'orange', 'pink'];
  /// print(colors.sublist(1, 3)); // [green, blue]
  /// ```
  ///
  /// If [end] is omitted, it defaults to the [length] of this list.
  ///
  /// ```dart
  /// final colors = <String>['red', 'green', 'blue', 'orange', 'pink'];
  /// print(colors.sublist(3)); // [orange, pink]
  /// ```
  ///
  /// The `start` and `end` positions must satisfy the relations
  /// 0 ≤ `start` ≤ `end` ≤ [length].
  /// If `end` is equal to `start`, then the returned list is empty.
  static List<dynamic> sublist(List input, int start, [int? end]) =>
      input.sublist(
        start,
        end,
      );

  /// Creates an [Iterable] that iterates over a range of elements.
  ///
  /// The returned iterable iterates over the elements of this list
  /// with positions greater than or equal to [start] and less than [end].
  ///
  /// The provided range, [start] and [end], must be valid at the time
  /// of the call.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The returned [Iterable] behaves like `skip(start).take(end - start)`.
  /// That is, it does *not* break if this list changes size, it just
  /// ends early if it reaches the end of the list early
  /// (if `end`, or even `start`, becomes greater than [length]).
  /// ```dart
  /// final colors = <String>['red', 'green', 'blue', 'orange', 'pink'];
  /// final firstRange = colors.getRange(0, 3);
  /// print(firstRange.join(', ')); // red, green, blue
  ///
  /// final secondRange = colors.getRange(2, 5);
  /// print(secondRange.join(', ')); // blue, orange, pink
  /// ```
  static Iterable<dynamic> getRange(List input, int start, int end) =>
      input.getRange(
        start,
        end,
      );

  /// Writes some elements of [iterable] into a range of this list.
  ///
  /// Copies the objects of [iterable], skipping [skipCount] objects first,
  /// into the range from [start], inclusive, to [end], exclusive, of this list.
  /// ```dart
  /// final list1 = <int>[1, 2, 3, 4];
  /// final list2 = <int>[5, 6, 7, 8, 9];
  /// // Copies the 4th and 5th items in list2 as the 2nd and 3rd items
  /// // of list1.
  /// const skipCount = 3;
  /// list1.setRange(1, 3, list2, skipCount);
  /// print(list1); // [1, 8, 9, 4]
  /// ```
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The [iterable] must have enough objects to fill the range from `start`
  /// to `end` after skipping [skipCount] objects.
  ///
  /// If `iterable` is this list, the operation correctly copies the elements
  /// originally in the range from `skipCount` to `skipCount + (end - start)` to
  /// the range `start` to `end`, even if the two ranges overlap.
  ///
  /// If `iterable` depends on this list in some other way, no guarantees are
  /// made.
  static void setRange(
          List input, int start, int end, Iterable<dynamic> iterable,
          [int skipCount = 0]) =>
      input.setRange(
        start,
        end,
        iterable,
        skipCount,
      );

  /// Removes a range of elements from the list.
  ///
  /// Removes the elements with positions greater than or equal to [start]
  /// and less than [end], from the list.
  /// This reduces the list's length by `end - start`.
  ///
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The list must be growable.
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4, 5];
  /// numbers.removeRange(1, 4);
  /// print(numbers); // [1, 5]
  /// ```
  static void removeRange(List input, int start, int end) => input.removeRange(
        start,
        end,
      );

  /// Overwrites a range of elements with [fillValue].
  ///
  /// Sets the positions greater than or equal to [start] and less than [end],
  /// to [fillValue].
  ///
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// If the element type is not nullable, the [fillValue] must be provided and
  /// must be non-`null`.
  ///
  /// Example:
  /// ```dart
  /// final words = List.filled(5, 'old');
  /// print(words); // [old, old, old, old, old]
  /// words.fillRange(1, 3, 'new');
  /// print(words); // [old, new, new, old, old]
  /// ```
  static void fillRange(List input, int start, int end, [dynamic fillValue]) =>
      input.fillRange(
        start,
        end,
        fillValue,
      );

  /// Replaces a range of elements with the elements of [replacements].
  ///
  /// Removes the objects in the range from [start] to [end],
  /// then inserts the elements of [replacements] at [start].
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4, 5];
  /// final replacements = [6, 7];
  /// numbers.replaceRange(1, 4, replacements);
  /// print(numbers); // [1, 6, 7, 5]
  /// ```
  /// The provided range, given by [start] and [end], must be valid.
  /// A range from [start] to [end] is valid if 0 ≤ `start` ≤ `end` ≤ [length].
  /// An empty range (with `end == start`) is valid.
  ///
  /// The operation `list.replaceRange(start, end, replacements)`
  /// is roughly equivalent to:
  /// ```dart
  /// final numbers = <int>[1, 2, 3, 4, 5];
  /// numbers.removeRange(1, 4);
  /// final replacements = [6, 7];
  /// numbers.insertAll(1, replacements);
  /// print(numbers); // [1, 6, 7, 5]
  /// ```
  /// but may be more efficient.
  ///
  /// The list must be growable.
  /// This method does not work on fixed-length lists, even when [replacements]
  /// has the same number of elements as the replaced range. In that case use
  /// [setRange] instead.
  static void replaceRange(
          List input, int start, int end, Iterable<dynamic> replacements) =>
      input.replaceRange(
        start,
        end,
        replacements,
      );

  /// An unmodifiable [Map] view of this list.
  ///
  /// The map uses the indices of this list as keys and the corresponding objects
  /// as values. The `Map.keys` [Iterable] iterates the indices of this list
  /// in numerical order.
  /// ```dart
  /// var words = <String>['fee', 'fi', 'fo', 'fum'];
  /// var map = words.asMap();  // {0: fee, 1: fi, 2: fo, 3: fum}
  /// map.keys.toList(); // [0, 1, 2, 3]
  /// ```
  static Map<int, dynamic> asMap(
    List input,
  ) =>
      input.asMap();

  /// Whether this list is equal to [other].
  ///
  /// Lists are, by default, only equal to themselves.
  /// Even if [other] is also a list, the equality comparison
  /// does not compare the elements of the two lists.
  static bool equalTo(List input, Object other) => input == other;
}

/// Num Sugar
class SugarNum {
  SugarNum._();

  /// Whether this number is a Not-a-Number value.
  ///
  /// Is `true` if this number is the [double.nan] value
  /// or any other of the possible [double] NaN values.
  /// Is `false` if this number is an integer,
  /// a finite double or an infinite double ([double.infinity]
  /// or [double.negativeInfinity]).
  ///
  /// All numbers satisfy exactly one of [isInfinite], [isFinite]
  /// and `isNaN`.
  static bool isNaN(num input) => input.isNaN;

  /// Whether this number is negative.
  ///
  /// A number is negative if it's smaller than zero,
  /// or if it is the double `-0.0`.
  /// This precludes a NaN value like [double.nan] from being negative.
  static bool isNegative(num input) => input.isNegative;

  /// Whether this number is positive infinity or negative infinity.
  ///
  /// Only satisfied by [double.infinity] and [double.negativeInfinity].
  ///
  /// All numbers satisfy exactly one of `isInfinite`, [isFinite]
  /// and [isNaN].
  static bool isInfinite(num input) => input.isInfinite;

  /// Whether this number is finite.
  ///
  /// The only non-finite numbers are NaN values, positive infinity, and
  /// negative infinity. All integers are finite.
  ///
  /// All numbers satisfy exactly one of [isInfinite], `isFinite`
  /// and [isNaN].
  static bool isFinite(num input) => input.isFinite;

  /// Negative one, zero or positive one depending on the sign and
  /// numerical value of this number.
  ///
  /// The value minus one if this number is less than zero,
  /// plus one if this number is greater than zero,
  /// and zero if this number is equal to zero.
  ///
  /// Returns NaN if this number is a [double] NaN value.
  ///
  /// Returns a number of the same type as this number.
  /// For doubles, `(-0.0).sign` is `-0.0`.
  ///
  /// The result satisfies:
  /// ```dart
  /// n == n.sign * n.abs()
  /// ```
  /// for all numbers `n` (except NaN, because NaN isn't `==` to itself).
  static num sign(num input) => input.sign;

  /// Test whether this value is numerically equal to `other`.
  ///
  /// If both operands are [double]s, they are equal if they have the same
  /// representation, except that:
  ///
  ///   * zero and minus zero (0.0 and -0.0) are considered equal. They
  ///     both have the numerical value zero.
  ///   * NaN is not equal to anything, including NaN. If either operand is
  ///     NaN, the result is always false.
  ///
  /// If one operand is a [double] and the other is an [int], they are equal if
  /// the double has an integer value (finite with no fractional part) and
  /// the numbers have the same numerical value.
  ///
  /// If both operands are integers, they are equal if they have the same value.
  ///
  /// Returns false if [other] is not a [num].
  ///
  /// Notice that the behavior for NaN is non-reflexive. This means that
  /// equality of double values is not a proper equality relation, as is
  /// otherwise required of `operator==`. Using NaN in, e.g., a [HashSet]
  /// will fail to work. The behavior is the standard IEEE-754 equality of
  /// doubles.
  ///
  /// If you can avoid NaN values, the remaining doubles do have a proper
  /// equality relation, and can be used safely.
  ///
  /// Use [compareTo] for a comparison that distinguishes zero and minus zero,
  /// and that considers NaN values as equal.
  static bool equalTo(num input, Object other) => input == other;

  /// Compares this to `other`.
  ///
  /// Returns a negative number if `this` is less than `other`, zero if they are
  /// equal, and a positive number if `this` is greater than `other`.
  ///
  /// The ordering represented by this method is a total ordering of [num]
  /// values. All distinct doubles are non-equal, as are all distinct integers,
  /// but integers are equal to doubles if they have the same numerical
  /// value.
  ///
  /// For doubles, the `compareTo` operation is different from the partial
  /// ordering given by [operator==], [operator<] and [operator>]. For example,
  /// IEEE doubles impose that `0.0 == -0.0` and all comparison operations on
  /// NaN return false.
  ///
  /// This function imposes a complete ordering for doubles. When using
  /// `compareTo`, the following properties hold:
  ///
  /// - All NaN values are considered equal, and greater than any numeric value.
  /// - -0.0 is less than 0.0 (and the integer 0), but greater than any non-zero
  ///    negative value.
  /// - Negative infinity is less than all other values and positive infinity is
  ///   greater than all non-NaN values.
  /// - All other values are compared using their numeric value.
  ///
  /// Examples:
  /// ```dart
  /// print(1.compareTo(2)); // => -1
  /// print(2.compareTo(1)); // => 1
  /// print(1.compareTo(1)); // => 0
  ///
  /// // The following comparisons yield different results than the
  /// // corresponding comparison operators.
  /// print((-0.0).compareTo(0.0));  // => -1
  /// print(double.nan.compareTo(double.nan));  // => 0
  /// print(double.infinity.compareTo(double.nan)); // => -1
  ///
  /// // -0.0, and NaN comparison operators have rules imposed by the IEEE
  /// // standard.
  /// print(-0.0 == 0.0); // => true
  /// print(double.nan == double.nan);  // => false
  /// print(double.infinity < double.nan);  // => false
  /// print(double.nan < double.infinity);  // => false
  /// print(double.nan == double.infinity);  // => false
  /// ```
  static int compareTo(num input, num other) => input.compareTo(
        other,
      );

  /// Adds [other] to this number.
  ///
  /// The result is an [int], as described by [int.+],
  /// if both this number and [other] is an integer,
  /// otherwise the result is a [double].
  static num adds(num input, num other) => input + other;

  /// Subtracts [other] from this number.
  ///
  /// The result is an [int], as described by [int.-],
  /// if both this number and [other] is an integer,
  /// otherwise the result is a [double].
  static num subtracts(num input, num other) => input - other;

  /// Multiplies this number by [other].
  ///
  /// The result is an [int], as described by [int.*],
  /// if both this number and [other] are integers,
  /// otherwise the result is a [double].
  static num multiplies(num input, num other) => input * other;

  /// Euclidean modulo of this number by [other].
  ///
  /// Returns the remainder of the Euclidean division.
  /// The Euclidean division of two integers `a` and `b`
  /// yields two integers `q` and `r` such that
  /// `a == b * q + r` and `0 <= r < b.abs()`.
  ///
  /// The Euclidean division is only defined for integers, but can be easily
  /// extended to work with doubles. In that case, `q` is still an integer,
  /// but `r` may have a non-integer value that still satisfies `0 <= r < |b|`.
  ///
  /// The sign of the returned value `r` is always positive.
  ///
  /// See [remainder] for the remainder of the truncating division.
  ///
  /// The result is an [int], as described by [int.%],
  /// if both this number and [other] are integers,
  /// otherwise the result is a [double].
  ///
  /// Example:
  /// ```dart
  /// print(5 % 3); // 2
  /// print(-5 % 3); // 1
  /// print(5 % -3); // 2
  /// print(-5 % -3); // 1
  /// ```
  static num euclideanModulo(num input, num other) => input % other;

  /// Divides this number by [other].
  static double divides(num input, num other) => input / other;

  /// Truncating division operator.
  ///
  /// Performs truncating division of this number by [other].
  /// Truncating division is division where a fractional result
  /// is converted to an integer by rounding towards zero.
  ///
  /// If both operands are [int]s, then [other] must not be zero.
  /// Then `a ~/ b` corresponds to `a.remainder(b)`
  /// such that `a == (a ~/ b) * b + a.remainder(b)`.
  ///
  /// If either operand is a [double], then the other operand is converted
  /// to a double before performing the division and truncation of the result.
  /// Then `a ~/ b` is equivalent to `(a / b).truncate()`.
  /// This means that the intermediate result of the double division
  /// must be a finite integer (not an infinity or [double.nan]).
  static int truncatingDivision(num input, num other) => input ~/ other;

  /// The negation of this value.
  ///
  /// The negation of a number is a number of the same kind
  /// (`int` or `double`) representing the negation of the
  /// numbers numerical value (the result of subtracting the
  /// number from zero), if that value *exists*.
  ///
  /// Negating a double gives a number with the same magnitude
  /// as the original value (`number.abs() == (-number).abs()`),
  /// and the opposite sign (`-(number.sign) == (-number).sign`).
  ///
  /// Negating an integer, `-number`, is equivalent to subtracting
  /// it from zero, `0 - number`.
  ///
  /// (Both properties generally also hold for the other type,
  /// but with a few edge case exceptions).
  static num negation(
    num input,
  ) =>
      -input;

  /// The remainder of the truncating division of `this` by [other].
  ///
  /// The result `r` of this operation satisfies:
  /// `this == (this ~/ other) * other + r`.
  /// As a consequence, the remainder `r` has the same sign as the dividend
  /// `this`.
  ///
  /// The result is an [int], as described by [int.remainder],
  /// if both this number and [other] are integers,
  /// otherwise the result is a [double].
  ///
  /// Example:
  /// ```dart
  /// print(5.remainder(3)); // 2
  /// print(-5.remainder(3)); // -2
  /// print(5.remainder(-3)); // 2
  /// print(-5.remainder(-3)); // -2
  /// ```
  static num remainder(num input, num other) => input.remainder(
        other,
      );

  /// Whether this number is numerically smaller than [other].
  ///
  /// Returns `true` if this number is smaller than [other].
  /// Returns `false` if this number is greater than or equal to [other]
  /// or if either value is a NaN value like [double.nan].
  static bool smallerThan(num input, num other) => input < other;

  /// Whether this number is numerically smaller than or equal to [other].
  ///
  /// Returns `true` if this number is smaller than or equal to [other].
  /// Returns `false` if this number is greater than [other]
  /// or if either value is a NaN value like [double.nan].
  static bool smallerThanOrEqualTo(num input, num other) => input <= other;

  /// Whether this number is numerically greater than [other].
  ///
  /// Returns `true` if this number is greater than [other].
  /// Returns `false` if this number is smaller than or equal to [other]
  /// or if either value is a NaN value like [double.nan].
  static bool greaterThan(num input, num other) => input > other;

  /// Whether this number is numerically greater than or equal to [other].
  ///
  /// Returns `true` if this number is greater than or equal to [other].
  /// Returns `false` if this number is smaller than [other]
  /// or if either value is a NaN value like [double.nan].
  static bool greaterThanOrEqualTo(num input, num other) => input >= other;

  /// The absolute value of this number.
  ///
  /// The absolute value is the value itself, if the value is non-negative,
  /// and `-value` if the value is negative.
  ///
  /// Integer overflow may cause the result of `-value` to stay negative.
  ///
  /// ```dart
  /// print((2).abs()); // 2
  /// print((-2.5).abs()); // 2.5
  /// ```
  static num abs(
    num input,
  ) =>
      input.abs();

  /// The integer closest to this number.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).round() == 4` and `(-3.5).round() == -4`.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  static int round(
    num input,
  ) =>
      input.round();

  /// The greatest integer no greater than this number.
  ///
  /// Rounds fractional values towards negative infinity.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  static int floor(
    num input,
  ) =>
      input.floor();

  /// The least integer no smaller than `this`.
  ///
  /// Rounds fractional values towards positive infinity.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  static int ceil(
    num input,
  ) =>
      input.ceil();

  /// The integer obtained by discarding any fractional digits from `this`.
  ///
  /// Rounds fractional values towards zero.
  ///
  /// The number must be finite (see [isFinite]).
  ///
  /// If the value is greater than the highest representable positive integer,
  /// the result is that highest positive integer.
  /// If the value is smaller than the highest representable negative integer,
  /// the result is that highest negative integer.
  static int truncate(
    num input,
  ) =>
      input.truncate();

  /// The double integer value closest to this value.
  ///
  /// Rounds away from zero when there is no closest integer:
  ///  `(3.5).roundToDouble() == 4` and `(-3.5).roundToDouble() == -4`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`,
  /// and `-0.0` is therefore considered closer to negative numbers than `0.0`.
  /// This means that for a value `d` in the range `-0.5 < d < 0.0`,
  /// the result is `-0.0`.
  static double roundToDouble(
    num input,
  ) =>
      input.roundToDouble();

  /// Returns the greatest double integer value no greater than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `0.0 < d < 1.0` will return `0.0`.
  static double floorToDouble(
    num input,
  ) =>
      input.floorToDouble();

  /// Returns the least double integer value no smaller than `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`.
  static double ceilToDouble(
    num input,
  ) =>
      input.ceilToDouble();

  /// Returns the double integer value obtained by discarding any fractional
  /// digits from the double value of `this`.
  ///
  /// If this is already an integer valued double, including `-0.0`, or it is a
  /// non-finite double value, the value is returned unmodified.
  ///
  /// For the purpose of rounding, `-0.0` is considered to be below `0.0`.
  /// A number `d` in the range `-1.0 < d < 0.0` will return `-0.0`, and
  /// in the range `0.0 < d < 1.0` it will return 0.0.
  static double truncateToDouble(
    num input,
  ) =>
      input.truncateToDouble();

  /// Returns this [num] clamped to be in the range [lowerLimit]-[upperLimit].
  ///
  /// The comparison is done using [compareTo] and therefore takes `-0.0` into
  /// account. This also implies that [double.nan] is treated as the maximal
  /// double value.
  ///
  /// The arguments [lowerLimit] and [upperLimit] must form a valid range where
  /// `lowerLimit.compareTo(upperLimit) <= 0`.
  ///
  /// Example:
  /// ```dart
  /// var result = 10.5.clamp(5, 10.0); // 10.0
  /// result = 0.75.clamp(5, 10.0); // 5
  /// result = (-10).clamp(-5, 5.0); // -5
  /// result = (-0.0).clamp(-5, 5.0); // -0.0
  /// ```
  static num clamp(num input, num lowerLimit, num upperLimit) => input.clamp(
        lowerLimit,
        upperLimit,
      );

  /// Truncates this [num] to an integer and returns the result as an [int].
  ///
  /// Equivalent to [truncate].
  static int toInt(
    num input,
  ) =>
      input.toInt();

  /// This number as a [double].
  ///
  /// If an integer number is not precisely representable as a [double],
  /// an approximation is returned.
  static double toDouble(
    num input,
  ) =>
      input.toDouble();

  /// A decimal-point string-representation of this number.
  ///
  /// Converts this number to a [double]
  /// before computing the string representation,
  /// as by [toDouble].
  ///
  /// If the absolute value of `this` is greater than or equal to `10^21`, then
  /// this methods returns an exponential representation computed by
  /// `this.toStringAsExponential()`. Otherwise the result
  /// is the closest string representation with exactly [fractionDigits] digits
  /// after the decimal point. If [fractionDigits] equals 0, then the decimal
  /// point is omitted.
  ///
  /// The parameter [fractionDigits] must be an integer satisfying:
  /// `0 <= fractionDigits <= 20`.
  ///
  /// Examples:
  /// ```dart
  /// 1.toStringAsFixed(3);  // 1.000
  /// (4321.12345678).toStringAsFixed(3);  // 4321.123
  /// (4321.12345678).toStringAsFixed(5);  // 4321.12346
  /// 123456789012345.toStringAsFixed(3);  // 123456789012345.000
  /// 10000000000000000.toStringAsFixed(4); // 10000000000000000.0000
  /// 5.25.toStringAsFixed(0); // 5
  /// ```
  static String toStringAsFixed(num input, int fractionDigits) =>
      input.toStringAsFixed(
        fractionDigits,
      );

  /// An exponential string-representation of this number.
  ///
  /// Converts this number to a [double]
  /// before computing the string representation.
  ///
  /// If [fractionDigits] is given, then it must be an integer satisfying:
  /// `0 <= fractionDigits <= 20`. In this case the string contains exactly
  /// [fractionDigits] after the decimal point. Otherwise, without the parameter,
  /// the returned string uses the shortest number of digits that accurately
  /// represent this number.
  ///
  /// If [fractionDigits] equals 0, then the decimal point is omitted.
  /// Examples:
  /// ```dart
  /// 1.toStringAsExponential();       // 1e+0
  /// 1.toStringAsExponential(3);      // 1.000e+0
  /// 123456.toStringAsExponential();  // 1.23456e+5
  /// 123456.toStringAsExponential(3); // 1.235e+5
  /// 123.toStringAsExponential(0);    // 1e+2
  /// ```
  static String toStringAsExponential(num input, [int? fractionDigits]) =>
      input.toStringAsExponential(
        fractionDigits,
      );

  /// A string representation with [precision] significant digits.
  ///
  /// Converts this number to a [double]
  /// and returns a string representation of that value
  /// with exactly [precision] significant digits.
  ///
  /// The parameter [precision] must be an integer satisfying:
  /// `1 <= precision <= 21`.
  ///
  /// Examples:
  /// ```dart
  /// 1.toStringAsPrecision(2);       // 1.0
  /// 1e15.toStringAsPrecision(3);    // 1.00e+15
  /// 1234567.toStringAsPrecision(3); // 1.23e+6
  /// 1234567.toStringAsPrecision(9); // 1234567.00
  /// 12345678901234567890.toStringAsPrecision(20); // 12345678901234567168
  /// 12345678901234567890.toStringAsPrecision(14); // 1.2345678901235e+19
  /// 0.00000012345.toStringAsPrecision(15); // 1.23450000000000e-7
  /// 0.0000012345.toStringAsPrecision(15);  // 0.00000123450000000000
  /// ```
  static String toStringAsPrecision(num input, int precision) =>
      input.toStringAsPrecision(
        precision,
      );

  /// The shortest string that correctly represents this number.
  ///
  /// All [double]s in the range `10^-6` (inclusive) to `10^21` (exclusive)
  /// are converted to their decimal representation with at least one digit
  /// after the decimal point. For all other doubles,
  /// except for special values like `NaN` or `Infinity`, this method returns an
  /// exponential representation (see [toStringAsExponential]).
  ///
  /// Returns `"NaN"` for [double.nan], `"Infinity"` for [double.infinity], and
  /// `"-Infinity"` for [double.negativeInfinity].
  ///
  /// An [int] is converted to a decimal representation with no decimal point.
  ///
  /// Examples:
  /// ```dart
  /// (0.000001).toString();  // "0.000001"
  /// (0.0000001).toString(); // "1e-7"
  /// (111111111111111111111.0).toString();  // "111111111111111110000.0"
  /// (100000000000000000000.0).toString();  // "100000000000000000000.0"
  /// (1000000000000000000000.0).toString(); // "1e+21"
  /// (1111111111111111111111.0).toString(); // "1.1111111111111111e+21"
  /// 1.toString(); // "1"
  /// 111111111111111111111.toString();  // "111111111111111110000"
  /// 100000000000000000000.toString();  // "100000000000000000000"
  /// 1000000000000000000000.toString(); // "1000000000000000000000"
  /// 1111111111111111111111.toString(); // "1111111111111111111111"
  /// 1.234e5.toString();   // 123400
  /// 1234.5e6.toString();  // 1234500000
  /// 12.345e67.toString(); // 1.2345e+68
  /// ```
  /// Note: the conversion may round the output if the returned string
  /// is accurate enough to uniquely identify the input-number.
  /// For example the most precise representation of the [double] `9e59` equals
  /// `"899999999999999918767229449717619953810131273674690656206848"`, but
  /// this method returns the shorter (but still uniquely identifying) `"9e59"`.
  static String numToString(
    num input,
  ) =>
      input.toString();

  /// Parses a string containing a number literal into a number.
  ///
  /// The method first tries to read the [input] as integer (similar to
  /// [int.parse] without a radix).
  /// If that fails, it tries to parse the [input] as a double (similar to
  /// [double.parse]).
  /// If that fails, too, it throws a [FormatException].
  ///
  /// Rather than throwing and immediately catching the [FormatException],
  /// instead use [tryParse] to handle a potential parsing error.
  ///
  /// For any number `n`, this function satisfies
  /// `identical(n, num.parse(n.toString()))` (except when `n` is a NaN `double`
  /// with a payload).
  ///
  /// The [onError] parameter is deprecated and will be removed.
  /// Instead of `num.parse(string, (string) { ... })`,
  /// you should use `num.tryParse(string) ?? (...)`.
  ///
  /// Examples:
  /// ```dart
  /// var value = num.parse('2021'); // 2021
  /// value = num.parse('3.14'); // 3.14
  /// value = num.parse('  3.14 \xA0'); // 3.14
  /// value = num.parse('0.'); // 0.0
  /// value = num.parse('.0'); // 0.0
  /// value = num.parse('-1.e3'); // -1000.0
  /// value = num.parse('1234E+7'); // 12340000000.0
  /// value = num.parse('+.12e-9'); // 1.2e-10
  /// value = num.parse('-NaN'); // NaN
  /// value = num.parse('0xFF'); // 255
  /// value = num.parse(double.infinity.toString()); // Infinity
  /// value = num.parse('1f'); // Throws.
  /// ```
  static num parse(String input, [num Function(String)? onError]) => num.parse(
        input,
        onError,
      );

  /// Parses a string containing a number literal into a number.
  ///
  /// Like [parse], except that this function returns `null` for invalid inputs
  /// instead of throwing.
  ///
  /// Examples:
  /// ```dart
  /// var value = num.tryParse('2021'); // 2021
  /// value = num.tryParse('3.14'); // 3.14
  /// value = num.tryParse('  3.14 \xA0'); // 3.14
  /// value = num.tryParse('0.'); // 0.0
  /// value = num.tryParse('.0'); // 0.0
  /// value = num.tryParse('-1.e3'); // -1000.0
  /// value = num.tryParse('1234E+7'); // 12340000000.0
  /// value = num.tryParse('+.12e-9'); // 1.2e-10
  /// value = num.tryParse('-NaN'); // NaN
  /// value = num.tryParse('0xFF'); // 255
  /// value = num.tryParse(double.infinity.toString()); // Infinity
  /// value = num.tryParse('1f'); // null
  /// ```
  static num? tryParse(String input) => num.tryParse(
        input,
      );
}

/// String Sugar
class SugarString {
  SugarString._();

  /// The length of the string.
  ///
  /// Returns the number of UTF-16 code units in this string. The number
  /// of [runes] might be fewer if the string contains characters outside
  /// the Basic Multilingual Plane (plane 0):
  /// ```dart
  /// 'Dart'.length;          // 4
  /// 'Dart'.runes.length;    // 4
  ///
  /// var clef = '\u{1D11E}';
  /// clef.length;            // 2
  /// clef.runes.length;      // 1
  /// ```
  static int length(String input) => input.length;

  /// Whether this string is empty.
  static bool isEmpty(String input) => input.isEmpty;

  /// Whether this string is not empty.
  static bool isNotEmpty(String input) => input.isNotEmpty;

  /// An unmodifiable list of the UTF-16 code units of this string.
  static List<int> codeUnits(String input) => input.codeUnits;

  /// An [Iterable] of Unicode code-points of this string.
  ///
  /// If the string contains surrogate pairs, they are combined and returned
  /// as one integer by this iterator. Unmatched surrogate halves are treated
  /// like valid 16-bit code-units.
  static Runes runes(String input) => input.runes;

  /// The character (as a single-code-unit [String]) at the given [index].
  ///
  /// The returned string represents exactly one UTF-16 code unit, which may be
  /// half of a surrogate pair. A single member of a surrogate pair is an
  /// invalid UTF-16 string:
  /// ```dart
  /// var clef = '\u{1D11E}';
  /// // These represent invalid UTF-16 strings.
  /// clef[0].codeUnits;      // [0xD834]
  /// clef[1].codeUnits;      // [0xDD1E]
  /// ```
  /// This method is equivalent to
  /// `String.fromCharCode(this.codeUnitAt(index))`.
  static String getChar(String input, int index) => input[index];

  /// Returns the 16-bit UTF-16 code unit at the given [index].
  static int codeUnitAt(String input, int index) => input.codeUnitAt(
        index,
      );

  /// Whether [other] is a `String` with the same sequence of code units.
  ///
  /// This method compares each individual code unit of the strings.
  /// It does not check for Unicode equivalence.
  /// For example, both the following strings represent the string 'Amélie',
  /// but due to their different encoding, are not equal:
  /// ```dart
  /// 'Am\xe9lie' == 'Ame\u{301}lie'; // false
  /// ```
  /// The first string encodes 'é' as a single unicode code unit (also
  /// a single rune), whereas the second string encodes it as 'e' with the
  /// combining accent character '◌́'.
  static bool equalTo(String input, Object other) => input == other;

  /// Compares this string to [other].
  ///
  /// Returns a negative value if `this` is ordered before `other`,
  /// a positive value if `this` is ordered after `other`,
  /// or zero if `this` and `other` are equivalent.
  ///
  /// The ordering is the same as the ordering of the code units at the first
  /// position where the two strings differ.
  /// If one string is a prefix of the other,
  /// then the shorter string is ordered before the longer string.
  /// If the strings have exactly the same content, they are equivalent with
  /// regard to the ordering.
  /// Ordering does not check for Unicode equivalence.
  /// The comparison is case sensitive.
  /// ```dart
  /// var relation = 'Dart'.compareTo('Go');
  /// print(relation); // < 0
  /// relation = 'Go'.compareTo('Forward');
  /// print(relation); // > 0
  /// relation = 'Forward'.compareTo('Forward');
  /// print(relation); // 0
  /// ```
  static int compareTo(String input, String other) => input.compareTo(
        other,
      );

  /// Whether this string ends with [other].
  ///
  /// For example:
  /// ```dart
  /// const string = 'Dart is open source';
  /// print(string.endsWith('urce')); // true
  /// ```
  static bool endsWith(String input, String other) => input.endsWith(
        other,
      );

  /// Whether this string starts with a match of [pattern].
  ///
  /// ```dart
  /// const string = 'Dart is open source';
  /// print(string.startsWith('Dar')); // true
  /// print(string.startsWith(RegExp(r'[A-Z][a-z]'))); // true
  /// ```
  /// If [index] is provided, this method checks if the substring starting
  /// at that index starts with a match of [pattern]:
  /// ```dart
  /// const string = 'Dart';
  /// print(string.startsWith('art', 0)); // false
  /// print(string.startsWith('art', 1)); // true
  /// print(string.startsWith(RegExp(r'\w{3}'), 2)); // false
  /// ```
  /// [index] must not be negative or greater than [length].
  ///
  /// A [RegExp] containing '^' does not match if the [index] is greater than
  /// zero and the regexp is not multi-line.
  /// The pattern works on the string as a whole, and does not extract
  /// a substring starting at [index] first:
  /// ```dart
  /// const string = 'Dart';
  /// print(string.startsWith(RegExp(r'^art'), 1)); // false
  /// print(string.startsWith(RegExp(r'art'), 1)); // true
  /// ```
  static bool startsWith(String input, Pattern pattern, [int index = 0]) =>
      input.startsWith(
        pattern,
        index,
      );

  /// Returns the position of the first match of [pattern] in this string,
  /// starting at [start], inclusive:
  /// ```dart
  /// const string = 'Dartisans';
  /// print(string.indexOf('art')); // 1
  /// print(string.indexOf(RegExp(r'[A-Z][a-z]'))); // 0
  /// ```
  /// Returns -1 if no match is found:
  /// ```dart
  /// const string = 'Dartisans';
  /// string.indexOf(RegExp(r'dart')); // -1
  /// ```
  /// The [start] must be non-negative and not greater than [length].
  static int indexOf(String input, Pattern pattern, [int start = 0]) =>
      input.indexOf(
        pattern,
        start,
      );

  /// The starting position of the last match [pattern] in this string.
  ///
  /// Finds a match of pattern by searching backward starting at [start]:
  /// ```dart
  /// const string = 'Dartisans';
  /// print(string.lastIndexOf('a')); // 6
  /// print(string.lastIndexOf(RegExp(r'a(r|n)'))); // 6
  /// ```
  /// Returns -1 if [pattern] could not be found in this string.
  /// ```dart
  /// const string = 'Dartisans';
  /// print(string.lastIndexOf(RegExp(r'DART'))); // -1
  /// ```
  /// If [start] is omitted, search starts from the end of the string.
  /// If supplied, [start] must be non-negative and not greater than [length].
  static int lastIndexOf(String input, Pattern pattern, [int? start]) =>
      input.lastIndexOf(
        pattern,
        start,
      );

  /// Creates a new string by concatenating this string with [other].
  ///
  /// Example:
  /// ```dart
  /// const string = 'dart' + 'lang'; // 'dartlang'
  /// ```
  static String concatenates(String input, String other) => input + other;

  /// The substring of this string from [start], inclusive, to [end], exclusive.
  ///
  /// Example:
  /// ```dart
  /// const string = 'dartlang';
  /// var result = string.substring(1); // 'artlang'
  /// result = string.substring(1, 4); // 'art'
  /// ```
  ///
  /// Both [start] and [end] must be non-negative and no greater than [length];
  /// [end], if provided, must be greater than or equal to [start].
  static String substring(String input, int start, [int? end]) =>
      input.substring(
        start,
        end,
      );

  /// The string without any leading and trailing whitespace.
  ///
  /// If the string contains leading or trailing whitespace, a new string with no
  /// leading and no trailing whitespace is returned:
  /// ```dart
  /// final trimmed = '\tDart is fun\n'.trim();
  /// print(trimmed); // 'Dart is fun'
  /// ```
  /// Otherwise, the original string itself is returned:
  /// ```dart
  /// const string1 = 'Dart';
  /// final string2 = string1.trim(); // 'Dart'
  /// print(identical(string1, string2)); // true
  /// ```
  /// Whitespace is defined by the Unicode White_Space property (as defined in
  /// version 6.2 or later) and the BOM character, 0xFEFF.
  ///
  /// Here is the list of trimmed characters according to Unicode version 6.3:
  /// ```plaintext
  ///     0009..000D    ; White_Space # Cc   <control-0009>..<control-000D>
  ///     0020          ; White_Space # Zs   SPACE
  ///     0085          ; White_Space # Cc   <control-0085>
  ///     00A0          ; White_Space # Zs   NO-BREAK SPACE
  ///     1680          ; White_Space # Zs   OGHAM SPACE MARK
  ///     2000..200A    ; White_Space # Zs   EN QUAD..HAIR SPACE
  ///     2028          ; White_Space # Zl   LINE SEPARATOR
  ///     2029          ; White_Space # Zp   PARAGRAPH SEPARATOR
  ///     202F          ; White_Space # Zs   NARROW NO-BREAK SPACE
  ///     205F          ; White_Space # Zs   MEDIUM MATHEMATICAL SPACE
  ///     3000          ; White_Space # Zs   IDEOGRAPHIC SPACE
  ///
  ///     FEFF          ; BOM                ZERO WIDTH NO_BREAK SPACE
  /// ```
  /// Some later versions of Unicode do not include U+0085 as a whitespace
  /// character. Whether it is trimmed depends on the Unicode version
  /// used by the system.
  static String trim(
    String input,
  ) =>
      input.trim();

  /// The string without any leading whitespace.
  ///
  /// As [trim], but only removes leading whitespace.
  /// ```dart
  /// final string = ' Dart '.trimLeft();
  /// print(string); // 'Dart '
  /// ```
  static String trimLeft(
    String input,
  ) =>
      input.trimLeft();

  /// The string without any trailing whitespace.
  ///
  /// As [trim], but only removes trailing whitespace.
  /// ```dart
  /// final string = ' Dart '.trimRight();
  /// print(string); // ' Dart'
  /// ```
  static String trimRight(
    String input,
  ) =>
      input.trimRight();

  /// Creates a new string by concatenating this string with itself a number
  /// of times.
  ///
  /// The result of `str * n` is equivalent to
  /// `str + str + ...`(n times)`... + str`.
  ///
  /// ```dart
  /// const string = 'Dart';
  /// final multiplied = string * 3;
  /// print(multiplied); // 'DartDartDart'
  /// ```
  /// Returns an empty string if [times] is zero or negative.
  static String multipliedConcatenates(String input, int times) =>
      input * times;

  /// Pads this string on the left if it is shorter than [width].
  ///
  /// Returns a new string that prepends [padding] onto this string
  /// one time for each position the length is less than [width].
  ///
  /// ```dart
  /// const string = 'D';
  /// print(string.padLeft(4)); // '   D'
  /// print(string.padLeft(2, 'x')); // 'xD'
  /// print(string.padLeft(4, 'y')); // 'yyyD'
  /// print(string.padLeft(4, '>>')); // '>>>>>>D'
  /// ```
  ///
  /// If [width] is already smaller than or equal to `this.length`,
  /// no padding is added. A negative `width` is treated as zero.
  ///
  /// If [padding] has length different from 1, the result will not
  /// have length `width`. This may be useful for cases where the
  /// padding is a longer string representing a single character, like
  /// `"&nbsp;"` or `"\u{10002}`".
  /// In that case, the user should make sure that `this.length` is
  /// the correct measure of the string's length.
  static String padLeft(String input, int width, [String padding = ' ']) =>
      input.padLeft(
        width,
        padding,
      );

  /// Pads this string on the right if it is shorter than [width].
  ///
  /// Returns a new string that appends [padding] after this string
  /// one time for each position the length is less than [width].
  ///
  /// ```dart
  /// const string = 'D';
  /// print(string.padRight(4)); // 'D    '
  /// print(string.padRight(2, 'x')); // 'Dx'
  /// print(string.padRight(4, 'y')); // 'Dyyy'
  /// print(string.padRight(4, '>>')); // 'D>>>>>>'
  /// ```
  ///
  /// If [width] is already smaller than or equal to `this.length`,
  /// no padding is added. A negative `width` is treated as zero.
  ///
  /// If [padding] has length different from 1, the result will not
  /// have length `width`. This may be useful for cases where the
  /// padding is a longer string representing a single character, like
  /// `"&nbsp;"` or `"\u{10002}`".
  /// In that case, the user should make sure that `this.length` is
  /// the correct measure of the string's length.
  static String padRight(String input, int width, [String padding = ' ']) =>
      input.padRight(
        width,
        padding,
      );

  /// Whether this string contains a match of [other].
  ///
  /// Example:
  /// ```dart
  /// const string = 'Dart strings';
  /// final containsD = string.contains('D'); // true
  /// final containsUpperCase = string.contains(RegExp(r'[A-Z]')); // true
  /// ```
  /// If [startIndex] is provided, this method matches only at or after that
  /// index:
  /// ```dart
  /// const string = 'Dart strings';
  /// final containsD = string.contains(RegExp('D'), 0); // true
  /// final caseSensitive = string.contains(RegExp(r'[A-Z]'), 1); // false
  /// ```
  /// The [startIndex] must not be negative or greater than [length].
  static bool contains(String input, Pattern other, [int startIndex = 0]) =>
      input.contains(
        other,
        startIndex,
      );

  /// Creates a new string with the first occurrence of [from] replaced by [to].
  ///
  /// Finds the first match of [from] in this string, starting from [startIndex],
  /// and creates a new string where that match is replaced with the [to] string.
  ///
  /// Example:
  /// ```dart
  /// '0.0001'.replaceFirst(RegExp(r'0'), ''); // '.0001'
  /// '0.0001'.replaceFirst(RegExp(r'0'), '7', 1); // '0.7001'
  /// ```
  static String replaceFirst(String input, Pattern from, String to,
          [int startIndex = 0]) =>
      input.replaceFirst(
        from,
        to,
        startIndex,
      );

  /// Replace the first occurrence of [from] in this string.
  ///
  /// ```dart
  /// const string = 'Dart is fun';
  /// print(string.replaceFirstMapped(
  ///     'fun', (m) => 'open source')); // Dart is open source
  ///
  /// print(string.replaceFirstMapped(
  ///     RegExp(r'\w(\w*)'), (m) => '<${m[0]}-${m[1]}>')); // <Dart-art> is fun
  /// ```
  ///
  /// Returns a new string, which is this string
  /// except that the first match of [from], starting from [startIndex],
  /// is replaced by the result of calling [replace] with the match object.
  ///
  /// The [startIndex] must be non-negative and no greater than [length].
  static String replaceFirstMapped(
          String input, Pattern from, String Function(Match) replace,
          [int startIndex = 0]) =>
      input.replaceFirstMapped(
        from,
        replace,
        startIndex,
      );

  /// Replaces all substrings that match [from] with [replace].
  ///
  /// Creates a new string in which the non-overlapping substrings matching
  /// [from] (the ones iterated by `from.allMatches(thisString)`) are replaced
  /// by the literal string [replace].
  /// ```dart
  /// 'resume'.replaceAll(RegExp(r'e'), 'é'); // 'résumé'
  /// ```
  /// Notice that the [replace] string is not interpreted. If the replacement
  /// depends on the match (for example, on a [RegExp]'s capture groups), use
  /// the [replaceAllMapped] method instead.
  static String replaceAll(String input, Pattern from, String replace) =>
      input.replaceAll(
        from,
        replace,
      );

  /// Replace all substrings that match [from] by a computed string.
  ///
  /// Creates a new string in which the non-overlapping substrings that match
  /// [from] (the ones iterated by `from.allMatches(thisString)`) are replaced
  /// by the result of calling [replace] on the corresponding [Match] object.
  ///
  /// This can be used to replace matches with new content that depends on the
  /// match, unlike [replaceAll] where the replacement string is always the same.
  ///
  /// The [replace] function is called with the [Match] generated
  /// by the pattern, and its result is used as replacement.
  ///
  /// The function defined below converts each word in a string to simplified
  /// 'pig latin' using [replaceAllMapped]:
  /// ```dart
  /// String pigLatin(String words) => words.replaceAllMapped(
  ///     RegExp(r'\b(\w*?)([aeiou]\w*)', caseSensitive: false),
  ///     (Match m) => "${m[2]}${m[1]}${m[1]!.isEmpty ? 'way' : 'ay'}");
  ///
  /// final result = pigLatin('I have a secret now!');
  /// print(result); // 'Iway avehay away ecretsay ownay!'
  /// ```
  static String replaceAllMapped(
          String input, Pattern from, String Function(Match) replace) =>
      input.replaceAllMapped(
        from,
        replace,
      );

  /// Replaces the substring from [start] to [end] with [replacement].
  ///
  /// Creates a new string equivalent to:
  /// ```dart
  /// this.substring(0, start) + replacement + this.substring(end)
  /// ```
  /// Example:
  /// ```dart
  /// const string = 'Dart is fun';
  /// final result = string.replaceRange(8, null, 'open source');
  /// print(result); // Dart is open source
  /// ```
  /// The [start] and [end] indices must specify a valid range of this string.
  /// That is `0 <= start <= end <= this.length`.
  /// If [end] is `null`, it defaults to [length].
  static String replaceRange(
          String input, int start, int? end, String replacement) =>
      input.replaceRange(
        start,
        end,
        replacement,
      );

  /// Splits the string at matches of [pattern] and returns a list of substrings.
  ///
  /// Finds all the matches of `pattern` in this string,
  /// as by using [Pattern.allMatches],
  /// and returns the list of the substrings between the matches,
  /// before the first match, and after the last match.
  /// ```dart
  /// const string = 'Hello world!';
  /// final splitted = string.split(' ');
  /// print(splitted); // [Hello, world!];
  /// ```
  /// If the pattern doesn't match this string at all,
  /// the result is always a list containing only the original string.
  ///
  /// If the [pattern] is a [String], then it's always the case that:
  /// ```dart
  /// string.split(pattern).join(pattern) == string
  /// ```
  ///
  /// If the first match is an empty match at the start of the string,
  /// the empty substring before it is not included in the result.
  /// If the last match is an empty match at the end of the string,
  /// the empty substring after it is not included in the result.
  /// If a match is empty, and it immediately follows a previous
  /// match (it starts at the position where the previous match ended),
  /// then the empty substring between the two matches is not
  /// included in the result.
  /// ```dart
  /// const string = 'abba';
  /// final re = RegExp(r'b*');
  /// // re.allMatches(string) will find four matches:
  /// // * empty match before first "a".
  /// // * match of "bb"
  /// // * empty match after "bb", before second "a"
  /// // * empty match after second "a".
  /// print(string.split(re)); // [a, a]
  /// ```
  ///
  /// A non-empty match at the start or end of the string, or after another
  /// match, is not treated specially, and will introduce empty substrings
  /// in the result:
  /// ```dart
  /// const string = 'abbaa';
  /// final splitted = string.split('a'); // ['', 'bb', '', '']
  /// ```
  ///
  /// If this string is the empty string, the result is an empty list
  /// if `pattern` matches the empty string, since the empty string
  /// before and after the first-and-last empty match are not included.
  /// (It is still a list containing the original empty string `[""]`
  /// if the pattern doesn't match).
  /// ```dart
  /// const string = '';
  /// print(string.split('')); // []
  /// print(string.split('a')); // []
  /// ```
  ///
  /// Splitting with an empty pattern splits the string into single-code unit
  /// strings.
  /// ```dart
  /// const string = 'Pub';
  /// print(string.split('')); // [P, u, b]
  ///
  /// // Same as:
  /// var codeUnitStrings = [
  ///   for (final unit in string.codeUnits) String.fromCharCode(unit)
  /// ];
  /// print(codeUnitStrings); // [P, u, b]
  /// ```
  ///
  /// Splitting happens at UTF-16 code unit boundaries,
  /// and not at rune (Unicode code point) boundaries:
  /// ```dart
  /// // String made up of two code units, but one rune.
  /// const string = '\u{1D11E}';
  /// final splitted = string.split('');
  /// print(splitted); // ['\ud834', '\udd1e'] - 2 unpaired surrogate values
  /// ```
  /// To get a list of strings containing the individual runes of a string,
  /// you should not use split.
  /// You can instead get a string for each rune as follows:
  /// ```dart
  /// const string = '\u{1F642}';
  /// for (final rune in string.runes) {
  ///   print(String.fromCharCode(rune));
  /// }
  /// ```
  static List<String> split(String input, Pattern pattern) => input.split(
        pattern,
      );

  /// Splits the string, converts its parts, and combines them into a new
  /// string.
  ///
  /// The [pattern] is used to split the string
  /// into parts and separating matches.
  /// Each match of [Pattern.allMatches] of [pattern] on this string is
  /// used as a match, and the substrings between the end of one match
  /// (or the start of the string) and the start of the next match (or the
  /// end of the string) is treated as a non-matched part.
  /// (There is no omission of leading or trailing empty matchs, like
  /// in [split], all matches and parts between the are included.)
  ///
  /// Each match is converted to a string by calling [onMatch]. If [onMatch]
  /// is omitted, the matched substring is used.
  ///
  /// Each non-matched part is converted to a string by a call to [onNonMatch].
  /// If [onNonMatch] is omitted, the non-matching substring itself is used.
  ///
  /// Then all the converted parts are concatenated into the resulting string.
  /// ```dart
  /// final result = 'Eats shoots leaves'.splitMapJoin(RegExp(r'shoots'),
  ///     onMatch: (m) => '${m[0]}', // (or no onMatch at all)
  ///     onNonMatch: (n) => '*');
  /// print(result); // *shoots*
  /// ```
  static String splitMapJoin(String input, Pattern pattern,
          {String Function(Match)? onMatch,
          String Function(String)? onNonMatch}) =>
      input.splitMapJoin(
        pattern,
        onMatch: onMatch,
        onNonMatch: onNonMatch,
      );

  /// Converts all characters in this string to lower case.
  ///
  /// If the string is already in all lower case, this method returns `this`.
  /// ```dart
  /// 'ALPHABET'.toLowerCase(); // 'alphabet'
  /// 'abc'.toLowerCase(); // 'abc'
  /// ```
  /// This function uses the language independent Unicode mapping and thus only
  /// works in some languages.
  static String toLowerCase(
    String input,
  ) =>
      input.toLowerCase();

  /// Converts all characters in this string to upper case.
  ///
  /// If the string is already in all upper case, this method returns `this`.
  /// ```dart
  /// 'alphabet'.toUpperCase(); // 'ALPHABET'
  /// 'ABC'.toUpperCase(); // 'ABC'
  /// ```
  /// This function uses the language independent Unicode mapping and thus only
  /// works in some languages.
  static String toUpperCase(
    String input,
  ) =>
      input.toUpperCase();
}
