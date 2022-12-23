import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedBirdSplashClipper extends CustomClipper<Path> {
  final GooeyEdge gooeyEdge;

  AnimatedBirdSplashClipper(this.gooeyEdge);

  @override
  Path getClip(Size size) {
    return gooeyEdge.buildPath(size);
  }

  @override
  bool shouldReclip(AnimatedBirdSplashClipper oldClipper) {
    return true;
  }
}

class GooeyEdge {
  static Random random = Random(4444);

  List<_Point> points = [];
  double damping = 0.85;
  double tension = 0.005;
  double roundness = 0.6;
  int count = 0;
  double edgeFactor = 0.0;
  int lastT = 0;

  GooeyEdge({this.count = 8, this.edgeFactor = 0.09}) {
    points = [];
    int ttl = count * 4 - 2;
    for (int i = 0; i < ttl; i++) {
      points.add(_updatePoint(_Point(), true));
    }
  }

  Path buildPath(Size size) {
    if (points.isEmpty) {
      return Path();
    }

    double w = size.width, h = size.height;
    double rowH = h / (count * 2 - 1), capSize = rowH * 0.67;
    double edge = w * edgeFactor, range = edge - capSize;

    Path path = Path();
    path.moveTo(edge, 0.0);

    _drawEdge(bool left) {
      int ttl = count * 2 - 1, start = 0;
      double baseX = w / 2 - edge, baseDir = 1;
      double y = 0, yD = rowH;

      if (left) {
        start = count * 2 - 1;
        baseX *= -1.0;
        baseDir = -1.0;
        y = h;
        yD *= -1.0;
      }

      for (int i = 0; i < ttl; i++) {
        _Point pt = points[i + start];
        double dir = (i % 2 == 0 ? 1 : -1) * baseDir;
        double curve = sin((i / ttl * roundness + (1.0 - roundness) / 2) *
            pi); // cut off the top bit of a sin curve
        double x = w / 2 + baseX * curve + range * curve * pt.value * dir;
        path.lineTo(x, y);
        path.quadraticBezierTo(
            x + capSize * dir, y, x + capSize * dir, y + yD / 2);
        path.quadraticBezierTo(x + capSize * dir, y + yD, x, y + yD);
        y += yD;
      }
    }

    _drawEdge(false);
    _drawEdge(true);

    path.close(); // bl

    return path;
  }

  void tick(Duration duration) {
    if (points.isEmpty) {
      return;
    }
    double t = min(1.5, (duration.inMilliseconds - lastT) / 1000 * 60);
    lastT = duration.inMilliseconds;
    double dampingT = pow(damping, t) as double;

    points.forEach((pt) {
      pt.vel += (pt.target - pt.value) * pt.tension;
      pt.vel *= dampingT;
      pt.value += pt.vel;
      pt.next -= t;
      if (pt.next <= 0) {
        _updatePoint(pt);
      }
    });
  }

  _Point _updatePoint(_Point pt, [bool jump = false]) {
    pt.target = random.nextDouble();
    if (jump) {
      pt.value = pt.target;
      pt.vel = 0.0;
    }
    pt.tension = 0.1 + random.nextDouble() * 0.9 * tension;
    pt.next = jump ? 0.0 : 120.0 + random.nextDouble() * 480.0;
    return pt;
  }
}

class _Point {
  double next = 0.0;
  double value = 0.0;
  double target = 0.0;
  double tension = 0.0;
  double vel = 0.0;
}
