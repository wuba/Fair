import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';

@FairPatch()
class WorkoutView extends StatelessWidget {
  const WorkoutView({Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 24, right: 24, top: 16, bottom: 18),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            FitnessAppTheme.nearlyDarkBlue,
            Color(0xff6F56E8)
          ], begin: Alignment.topLeft, end: Alignment.bottomRight),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8.0),
              bottomLeft: Radius.circular(8.0),
              bottomRight: Radius.circular(8.0),
              topRight: Radius.circular(68.0)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Sugar.colorsWithOpacity(FitnessAppTheme.grey, 0.6),
                offset: Offset(1.1, 1.1),
                blurRadius: 10.0),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Next workout',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: FitnessAppTheme.fontName,
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  letterSpacing: 0.0,
                  color: FitnessAppTheme.white,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: const Text(
                  'Legs Toning and\nGlutes Workout at Home',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: FitnessAppTheme.fontName,
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    letterSpacing: 0.0,
                    color: FitnessAppTheme.white,
                  ),
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.timer,
                        color: FitnessAppTheme.white,
                        size: 16,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: const Text(
                        '68 min',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: FitnessAppTheme.fontName,
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          letterSpacing: 0.0,
                          color: FitnessAppTheme.white,
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: FitnessAppTheme.nearlyWhite,
                        shape: BoxShape.circle,
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                              color: Sugar.colorsWithOpacity(FitnessAppTheme.nearlyBlack, 0.4),
                              offset: Offset(8.0, 8.0),
                              blurRadius: 8.0),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Icon(
                          Icons.arrow_right,
                          color: Color(0xFF6F56E8),
                          size: 44,
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
