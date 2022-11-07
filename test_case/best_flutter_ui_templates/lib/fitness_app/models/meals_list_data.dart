import 'package:fair/fair.dart';

@FairBinding()
class MealsListData {
  const MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
  });

  final String imagePath;
  final String titleTxt;
  final String startColor;
  final String endColor;
  final List<String>? meals;
  final int kacl;

  static const icon1 = MealsListData(
    imagePath: 'assets/fitness_app/breakfast.png',
    titleTxt: 'Breakfast',
    kacl: 525,
    meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
    startColor: '#FA7D82',
    endColor: '#FFB295',
  );

  static const icon2 = MealsListData(
    imagePath: 'assets/fitness_app/lunch.png',
    titleTxt: 'Lunch',
    kacl: 602,
    meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
    startColor: '#738AE6',
    endColor: '#5C5EDD',
  );

  static const icon3 = MealsListData(
    imagePath: 'assets/fitness_app/snack.png',
    titleTxt: 'Snack',
    kacl: 0,
    meals: <String>['Recommend:', '800 kcal'],
    startColor: '#FE95B6',
    endColor: '#FF5287',
  );

  static const icon4 = MealsListData(
    imagePath: 'assets/fitness_app/dinner.png',
    titleTxt: 'Dinner',
    kacl: 0,
    meals: <String>['Recommend:', '703 kcal'],
    startColor: '#6F72CA',
    endColor: '#1E1466',
  );

  static List<MealsListData> getList() {
    return tabIconsList;
  }

  static const List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Breakfast',
      kacl: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Lunch',
      kacl: 602,
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Snack',
      kacl: 0,
      meals: <String>['Recommend:', '800 kcal'],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      kacl: 0,
      meals: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
