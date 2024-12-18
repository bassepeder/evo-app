import 'package:flutter/material.dart';

class FadeInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;

  const FadeInWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 350),
  });

  @override
  _FadeInWidgetState createState() => _FadeInWidgetState();
}

class _FadeInWidgetState extends State<FadeInWidget> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start fading in when the widget is inserted into the widget tree
    Future.delayed(Duration.zero, () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _opacity,
      duration: widget.duration,
      child: widget.child,
    );
  }
}
