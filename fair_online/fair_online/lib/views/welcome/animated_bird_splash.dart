import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/fair_logo.dart';
import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/views/welcome/animated_bird_splash_clipper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AnimatedBirdSplashWidget extends StatefulWidget {
  final Alignment alignment;
  final bool showText;
  final bool showLogo;

  const AnimatedBirdSplashWidget(
      {Key? key,
      this.alignment = Alignment.center,
      this.showText = false,
      this.showLogo = true})
      : super(key: key);

  @override
  _AnimatedBirdSplashState createState() => _AnimatedBirdSplashState();
}

class _AnimatedBirdSplashState extends State<AnimatedBirdSplashWidget>
    with SingleTickerProviderStateMixin {
  late GooeyEdge _gooeyEdge;

  late AnimationController _animationController;
  double _cloudXOffset = 0.0;

  @override
  void initState() {
    _gooeyEdge = GooeyEdge();
    _animationController = AnimationController(vsync: this);
    _animationController.repeat(
        reverse: true, min: 0.0, max: 1.0, period: 800.milliseconds);
    _animationController.addListener(_tick);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _tick() {
    _gooeyEdge.tick(
        _animationController.lastElapsedDuration ?? Duration(milliseconds: 0));
    _cloudXOffset += _animationController.velocity * 0.08;
    while (_cloudXOffset > 800.0) {
      _cloudXOffset -= 800.0;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    AppTheme theme = context.watch();
    String bgImagePath = "assets/images/onboarding-bg.png";
    String cloudImagePath = "assets/images/onboarding-clouds.png";
    String fgImagePath = "assets/images/onboarding-birds.png";
    return Stack(
      children: [
        Stack(children: [
          /// Clipped Image Stack
          ClipPath(
            clipper: AnimatedBirdSplashClipper(_gooeyEdge),
            child: Stack(children: [
              /// BG
              _BuildImage(bgImagePath, BoxFit.fill)
                  .positioned(left: 0, top: 0, right: 0, bottom: 0),

              /// CLOUD 1
              _BuildImage(cloudImagePath)
                  .translate(offset: Offset(_cloudXOffset, 0))
                  .fractionallySizedBox(heightFactor: 0.4),

              /// CLOUD2
              _BuildImage(cloudImagePath)
                  .translate(offset: Offset(-800 + _cloudXOffset, 0))
                  .fractionallySizedBox(heightFactor: 0.4),

              /// Foreground
              _BuildImage(fgImagePath, BoxFit.scaleDown).center(),
            ]),
          ).aspectRatio(aspectRatio: 1.8).constrained(maxWidth: 700),

          /// Loading Text
          Text(
            "加载中...",
            style: TextStyles.T1.textColor(theme.accent1Darker),
            textAlign: TextAlign.center,
          ) //Bottom positioned, fades in and out
              .alignment(Alignment.bottomCenter)
              .translate(
                  offset: Offset(
                      0, 46)) // Offset text below the bottom edge of the images
              .opacity(widget.showText ? 1 : 0, animate: true)
              .animate(Durations.slow, Curves.easeOut)
              .positioned(left: 0, top: 0, right: 0, bottom: 0)
        ]).center(),

        /// Flock Logo
        if (widget.showLogo)
          FairLogo(168, theme.accent1Darker)
              .center()
              .constrained(width: 200, height: 168)
              .alignment(Alignment(-0.84, -0.84)),
      ],
    );
  }

  Widget _BuildImage(String url, [BoxFit fit = BoxFit.fitHeight]) =>
      Image.asset(url, filterQuality: FilterQuality.high, fit: fit);
}
