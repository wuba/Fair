import 'dart:math';

import 'package:fair_online/app_extensions.dart';
import 'package:fair_online/base/components/animated_panel.dart';
import 'package:fair_online/base/components/fading_index_stack.dart';
import 'package:fair_online/base/components/styled_progress_spinner.dart';
import 'package:fair_online/base/page_routes.dart';
import 'package:fair_online/app/styles.dart';
import 'package:fair_online/app/themes.dart';
import 'package:fair_online/views/project/project_page.dart';
import 'package:fair_online/views/welcome/animated_bird_splash.dart';
import 'package:fair_online/views/welcome/welcome_page_step.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WelcomePage extends StatefulWidget {
  final bool initialPanelOpen;

  const WelcomePage({Key? key, this.initialPanelOpen = false})
      : super(key: key);

  @override
  WelcomePageState createState() => WelcomePageState();
}

class WelcomePageState extends State<WelcomePage> {
  int pageIndex = 0;

  bool get isLoading => _isLoading;
  bool _isLoading = false;

  set isLoading(bool value) => setState(() => _isLoading = value);

  Size prevSize = Size.zero;
  bool showContent = false;

  @override
  void initState() {
    showContent = widget.initialPanelOpen;
    Future.delayed(
        Duration(milliseconds: 1000), () => setState(() => showContent = true));
    super.initState();
  }

  void showPanel(value) => setState(() => showContent = value);

  void refreshDataAndLoadApp() async {
    isLoading = true;
    Navigator.push<void>(
        context,
        PageRoutes.fade(
            () => ProjectPage(), Durations.slow.inMilliseconds * .001));
  }

  void handleStartPressed() async {
    refreshDataAndLoadApp();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.value(value: this, child: _WelcomePageStateView());
  }
}

class _WelcomePageStateView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    WelcomePageState state = context.watch();
    double contentWidth = 300;
    double maxWidth = 700;
    contentWidth += min(maxWidth, context.widthPx * .15);

    bool skipBirdTransition = false;
    if (state.prevSize != context.sizePx) skipBirdTransition = true;
    state.prevSize = context.sizePx;

    return Scaffold(
        backgroundColor: Colors.white,
        body: TweenAnimationBuilder<double>(
          duration: Durations.slow,
          tween: Tween(begin: 0, end: 1),
          builder: (_, value, ___) => Opacity(
            opacity: value,
            child: Center(
              child: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: AnimatedBirdSplashWidget(
                      showText: state.isLoading,
                    ),
                  )
                      .opacity(1.0)
                      .padding(
                          right: (state.showContent ? contentWidth : 0),
                          animate: true)
                      .animate(
                        skipBirdTransition ? 0.seconds : Durations.slow,
                        Curves.easeOut,
                      ),
                  _WelcomeContentStack()
                      .width(contentWidth)
                      // Use an AnimatedPanel to slide the panel open/closed
                      .animatedPanelX(
                        isClosed: !state.showContent,
                        closeX: context.widthPx,
                        curve: Curves.easeOut,
                        duration: Durations.slow.inMilliseconds * .001,
                      )
                      // Pin the left side on fullscreen, respect existing width otherwise
                      .positioned(top: 0, bottom: 0, right: 0, left: null)
                ],
              ),
            ),
          ),
        ));
  }
}

class _WelcomeContentStack extends StatelessWidget {
  const _WelcomeContentStack({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    WelcomePageState state = context.watch();

    BorderRadius? getBgShape() => BorderRadius.only(
        topLeft: Radius.circular(Corners.s10),
        bottomLeft: Radius.circular(Corners.s10));

    AppTheme theme = context.watch();
    return state.isLoading
        ? StyledProgressSpinner().backgroundColor(theme.accent1)
        : Stack(
            children: [
              FadingIndexedStack(
                duration: Durations.slow,
                index: state.pageIndex,
                children: <Widget>[WelcomePageStep().scrollable().center()],
              ).padding(vertical: Insets.l * 1.5).center(),
            ],
          )
            .padding(horizontal: Insets.l)
            .decorated(color: theme.accent1, borderRadius: getBgShape())
            .alignment(Alignment.center)
            .width(double.infinity);
  }
}
