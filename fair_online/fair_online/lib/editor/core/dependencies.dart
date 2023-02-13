/// A simple dependency manager.
library core.dependencies;

import 'dart:async';

typedef VoidFunc = void Function();

Dependencies get deps => Dependencies.instance;

/// A simple dependency manager. This class manages a collection of singletons.
/// You can create separate `Dependency` instances to manage separate sets of
/// collections (for instance, one for testing). Or, you can use the single
/// [dependency] instance defined in this library to set up all the singletons
/// for your application.
///
///     Dependencies dependencies = new Dependencies();
///     dependencies.setDependency(CatManager, catManager);
///     dependencies.setDependency(DogManager, dogs);
///
///     ...
///
///     CatManager cats = dependencies[CatManager];
///     cats.corale();
///
/// When you want to set up a new series of services, for doing something like
/// executing tests with mocked out providers, you can use [runInZone]. So:
///
///     Dependencies dependencies = new Dependencies();
///     dependencies.setDependency(CatManager, new MockCatManager());
///     dependencies.setDependency(DogManager, new MockDogManager());
///     dependencies.runInZone(executeTests);
///
/// It will execute the method [executeTests] in a new Zone. Any queries to
/// [Dependencies.instance] will return the new dependencies set up for that
/// zone.
class Dependencies {
  static late Dependencies _global;

  static void setGlobalInstance(Dependencies deps) {
    _global = deps;
  }

  /// Get the current logical instance. This is the instance associated with the
  /// current Zone, parent Zones, or the global instance.
  static Dependencies get instance {
    final deps = Zone.current['dependencies'] as Dependencies?;
    return deps ?? _global;
  }

  final _instances = <Type, dynamic>{};

  Dependencies();

  Dependencies? get parent => _calcParent(Zone.current);

  dynamic getDependency(Type type) {
    if (_instances.containsKey(type)) {
      return _instances[type];
    }

    final parent = _calcParent(Zone.current);
    return parent?.getDependency(type);
  }

  void setDependency(Type type, dynamic instance) {
    _instances[type] = instance;
  }

  dynamic operator [](Type type) => getDependency(type);

  void operator []=(Type type, dynamic instance) =>
      setDependency(type, instance);

  /// Return the [Type]s defined in this immediate [Dependencies] instance.
  Iterable<Type> get types => _instances.keys;

  /// Execute the given function in a new Zone. That zone is populated with the
  /// dependencies of this object. Any requests for dependencies are first
  /// satisfied with this [Dependencies] object, and then delegate up to
  /// [Dependencies] for parent Zones.
  void runInZone(VoidFunc function) {
    final zone = Zone.current.fork(zoneValues: {'dependencies': this});
    zone.run(function);
  }

  /// Determine the [Dependencies] instance that is the logical parent of the
  /// [Dependencies] for the given [Zone].
  Dependencies? _calcParent(Zone zone) {
    if (this == _global) return null;

    final parentZone = zone.parent;
    if (parentZone == null) return _global;

    final deps = parentZone['dependencies'] as Dependencies?;
    if (deps == this) {
      return _calcParent(parentZone);
    } else {
      return deps ?? _global;
    }
  }
}
