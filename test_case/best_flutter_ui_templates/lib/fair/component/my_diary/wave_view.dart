import 'dart:math' as math;
import 'package:best_flutter_ui_templates/fitness_app/fitness_app_theme.dart';
import 'package:fair/fair.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as vector;

@FairBinding()
class WaveView extends StatefulWidget {
  final double percentageValue;

  const WaveView({Key? key, this.percentageValue = 100.0}) : super(key: key);
  @override
  _WaveViewState createState() => _WaveViewState();
}

class _WaveViewState extends State<WaveView> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Stack(
        children: <Widget>[
          new ClipPath(
            child: new Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyDarkBlue.withOpacity(0.5),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0),
                    bottomLeft: Radius.circular(80.0),
                    bottomRight: Radius.circular(80.0),
                    topRight: Radius.circular(80.0)),
                gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue.withOpacity(0.2),
                    FitnessAppTheme.nearlyDarkBlue.withOpacity(0.5)
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          new ClipPath(
            child: new Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.nearlyDarkBlue,
                gradient: LinearGradient(
                  colors: [
                    FitnessAppTheme.nearlyDarkBlue.withOpacity(0.4),
                    FitnessAppTheme.nearlyDarkBlue
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(80.0),
                    bottomLeft: Radius.circular(80.0),
                    bottomRight: Radius.circular(80.0),
                    topRight: Radius.circular(80.0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 48),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    widget.percentageValue.round().toString(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: FitnessAppTheme.fontName,
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                      letterSpacing: 0.0,
                      color: FitnessAppTheme.white,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(
                      '%',
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
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 6,
            bottom: 8,
            child: Container(
              width: 2,
              height: 2,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 24,
            right: 0,
            bottom: 16,
            child: Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 24,
            bottom: 32,
            child: Container(
              width: 3,
              height: 3,
              decoration: BoxDecoration(
                color: FitnessAppTheme.white.withOpacity(0.4),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 20,
            bottom: 0,
            child: new Transform(
              transform: new Matrix4.translationValues(
                  0.0, 16, 0.0),
              child: Container(
                width: 4,
                height: 4,
                decoration: BoxDecoration(
                  color: FitnessAppTheme.white.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Column(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Image.asset("assets/fitness_app/bottle.png"),
              ),
            ],
          )
        ],
      )
    );
  }
}