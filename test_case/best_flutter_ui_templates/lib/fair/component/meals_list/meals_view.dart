import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:best_flutter_ui_templates/fitness_app/models/meals_list_data.dart';
import 'package:best_flutter_ui_templates/hex_color.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairBinding()
class MealsView extends StatelessWidget {
  const MealsView({Key? key, this.mealsListData}) : super(key: key);

  final MealsListData? mealsListData;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Stack(
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.only(top: 32, left: 8, right: 8, bottom: 16),
            child: Container(
              decoration: BoxDecoration(
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Sugar.colorsWithOpacity(
                          HexColor(mealsListData!.endColor), 0.6),
                      offset: const Offset(1.1, 4.0),
                      blurRadius: 8.0),
                ],
                gradient: LinearGradient(
                  colors: <HexColor>[
                    HexColor(mealsListData!.startColor),
                    HexColor(mealsListData!.endColor),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: const BorderRadius.only(
                  bottomRight: Radius.circular(8.0),
                  bottomLeft: Radius.circular(8.0),
                  topLeft: Radius.circular(8.0),
                  topRight: Radius.circular(54.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 54, left: 16, right: 16, bottom: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      mealsListData!.titleTxt,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 0.2,
                        color: FitnessAppTheme.white,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              mealsListData!.meals!.join('\n'),
                              style: TextStyle(
                                fontFamily: FitnessAppTheme.fontName,
                                fontWeight: FontWeight.w500,
                                fontSize: 10,
                                letterSpacing: 0.2,
                                color: FitnessAppTheme.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    mealsListData?.kacl != 0
                        ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          mealsListData!.kacl.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontFamily: FitnessAppTheme.fontName,
                            fontWeight: FontWeight.w500,
                            fontSize: 24,
                            letterSpacing: 0.2,
                            color: FitnessAppTheme.white,
                          ),
                        ),
                        Padding(
                          padding:
                          const EdgeInsets.only(left: 4, bottom: 3),
                          child: Text(
                            'kcal',
                            style: TextStyle(
                              fontFamily: FitnessAppTheme.fontName,
                              fontWeight: FontWeight.w500,
                              fontSize: 10,
                              letterSpacing: 0.2,
                              color: FitnessAppTheme.white,
                            ),
                          ),
                        ),
                      ],
                    )
                        : Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Sugar.colorsWithOpacity(
                                  FitnessAppTheme.nearlyBlack, 0.4),
                              offset: Offset(8.0, 8.0),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.add,
                          color: HexColor(mealsListData!.endColor),
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: Container(
              width: 84,
              height: 84,
              decoration: BoxDecoration(
                color:
                Sugar.colorsWithOpacity(FitnessAppTheme.nearlyWhite, 0.2),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 8,
            child: SizedBox(
              width: 80,
              height: 80,
              child: Image.asset(mealsListData!.imagePath),
            ),
          )
        ],
      ),
    );
  }
}