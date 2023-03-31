rm -rf lib/src/generated.fair.dart
flutter clean
flutter packages get
flutter pub run build_runner build --delete-conflicting-outputs

cp -r build/fair assets/