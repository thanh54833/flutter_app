import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

main() => runApp(App());

class App extends StatelessWidget {
  build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: StateApp(),
      ),
    );
  }
}

class StateApp extends StatefulWidget {
  createState() => _StateApp();
}

class _StateApp extends State<StateApp> {
  build(BuildContext context) {
    return Container(
      child: Center(
        child: Container(
          color: Colors.red,
          child: Container(
            height: 150,
            width: 150,
            color: Colors.green,
            child: FabLoader(
              child: Container(),
            ),
          ),
          //padding: EdgeInsets.all(20),
        ),
      ),
      color: Colors.white,
    );
  }
}

class ArcPainter extends CustomPainter {
  ArcPainter(
      {this.strokeWidth,
      this.backgroundColor,
      this.color,
      this.headValue,
      this.tailValue,
      this.stepValue,
      this.rotationValue})
      : arcStart = _startAngle + // -pi / 2
            tailValue * 3 / 2 * pi +
            rotationValue * pi * 1.7 -
            stepValue * 0.8 * pi,
        arcSweep =
            max(headValue * 3 / 2 * pi - tailValue * 3 / 2 * pi, _epsilon);

  final Color backgroundColor;
  final Color color;
  final double headValue;
  final double tailValue;
  final int stepValue;
  final double rotationValue;
  final double strokeWidth;
  final double arcStart;
  final double arcSweep;

  static const double _twoPi = pi * 2.0;
  static const double _epsilon = .001;

  // Canvas.drawArc(r, 0, 2*PI) doesn't draw anything, so just get close.
  static const double _completeCircumference = _twoPi - _epsilon;
  static const double _startAngle = -pi / 2.0;

  @override
  void paint(Canvas canvas, Size size) {
    if (backgroundColor != null) {
      final Paint backgroundPaint = Paint()
        ..color = backgroundColor
        ..strokeWidth = strokeWidth
        ..style = PaintingStyle.stroke;
      canvas.drawArc(
          Offset(-strokeWidth / 2, -strokeWidth / 2) &
              Size(size.width + strokeWidth, size.height + strokeWidth),
          0,
          _completeCircumference,
          false,
          backgroundPaint);
    }

    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.square;

    // canvas.drawArc(
    //     Offset(-strokeWidth / 2, -strokeWidth / 2) &
    //     Size(size.width + strokeWidth, size.height + strokeWidth),
    //     arcStart,
    //     arcSweep,
    //     false,
    //     paint);

    //a rectangle
    canvas.drawRect(Offset(0, 0) & Size(150, 150), paint);
  }

  @override
  bool shouldRepaint(ArcPainter oldPainter) {
    return oldPainter.backgroundColor != backgroundColor ||
        oldPainter.color != color ||
        oldPainter.headValue != headValue ||
        oldPainter.tailValue != tailValue ||
        oldPainter.stepValue != stepValue ||
        oldPainter.rotationValue != rotationValue ||
        oldPainter.strokeWidth != strokeWidth;
  }
}

/// Draws a loading arc around the child view, supposed to be a
/// FloatingActionButton.
class FabLoader extends StatefulWidget {
  final Color color;
  final Color backgroundColor;
  final double strokeWidth;
  final Widget child;

  FabLoader({
    this.color = Colors.orange,
    this.backgroundColor = Colors.transparent,
    this.strokeWidth = 4,
    @required this.child,
  })  : assert(color != null),
        assert(backgroundColor != null),
        assert(strokeWidth != null),
        assert(child != null);

  @override
  _FabLoadingWidget createState() =>
      new _FabLoadingWidget(strokeWidth: strokeWidth, child: child);
}

// Arc head will be lead by this Tween curve. This is for the first half of the
// animation, while the arc is growing from its head.
final Animatable<double> _kStrokeHeadTween = CurveTween(
  curve: const Interval(0.0, 0.5, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

// Arc tail will be lead by this Tween curve. This is for the second half of the
// animation, when the arc is shrinking from its tail.
final Animatable<double> _kStrokeTailTween = CurveTween(
  curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
).chain(CurveTween(
  curve: const SawTooth(5),
));

// The current progress step will be lead by this stepped Tween.
final Animatable<int> _kStepTween = StepTween(begin: 0, end: 5);

// The rotation for the arc as a whole will be lead by this Tween curve.
final Animatable<double> _kRotationTween = CurveTween(curve: const SawTooth(5));

class _FabLoadingWidget extends State<FabLoader>
    with SingleTickerProviderStateMixin {
  final Widget child;
  final double strokeWidth;

  AnimationController _controller;

  _FabLoadingWidget({@required this.strokeWidth, @required this.child});

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );
    _controller.repeat(); // we want it to repeat over and over (indeterminate)
  }

  @override
  void didUpdateWidget(FabLoader oldWidget) {
    super.didUpdateWidget(oldWidget);
    // We want to start animation again if the widget is updated.
    if (!_controller.isAnimating) {
      _controller.repeat();
    }
  }

  @override
  void dispose() {
    _controller.dispose(); // avoid leaks
    super.dispose();
  }

  Widget _buildIndicator(
      double headValue, double tailValue, int stepValue, double rotationValue) {
    return new CustomPaint(
      child: child,
      foregroundPainter: new ArcPainter(
          strokeWidth: strokeWidth,
          backgroundColor: widget.backgroundColor,
          color: widget.color,
          headValue: headValue,
          tailValue: tailValue,
          stepValue: stepValue,
          rotationValue: rotationValue),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget child) {
        return _buildIndicator(
          _kStrokeHeadTween.evaluate(_controller),
          _kStrokeTailTween.evaluate(_controller),
          _kStepTween.evaluate(_controller),
          _kRotationTween.evaluate(_controller),
        );
      },
    );
  }
}
