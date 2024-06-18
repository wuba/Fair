
rm -rf lib/src/generated.fair.dart
flutter clean
flutter packages get
flutter pub run build_runner build --delete-conflicting-outputs

#cp -r build/fair assets/

#rm -rf assets/fair
mkdir assets/fair

for file in build/fair/*
do
    if [ "${file##*.}"x = "json"x ] || [ "${file##*.}"x = "js"x ] || [ "${file##*.}"x = "bin"x ]
    then
    cp $file assets/fair    
    fi
done