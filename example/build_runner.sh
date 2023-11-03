fvm flutter clean

echo "----- flutter clean finish -----"

fvm flutter pub get

echo "----- flutter pub get finish -----"

fvm flutter pub run build_runner build --delete-conflicting-outputs

echo "----- flutter pub run build_runner build finish -----"
