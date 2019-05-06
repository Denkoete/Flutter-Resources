library flare_splash_screen;

import 'package:flare_loading/flare_loading.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  final String name;
  final Widget next;
  final VoidCallback onFinished;
  final double width;
  final double height;
  final Color backgroundColor;
  final Alignment alignment;
  final Future<void> Function() until;
  final String loopAnimation;
  final String endAnimation;
  final String startAnimation;
  final RoutePageBuilder transitionsBuilder;
  final bool isLoading;

  factory SplashScreen.callback({
    @required String name,
    @required VoidCallback onFinished,
    Key key,
    Future Function() until,
    bool isLoading,
    Color backgroundColor,
    String loopAnimation,
    Alignment alignment = Alignment.center,
    double width,
    double height,
    String endAnimation,
    RoutePageBuilder transitionsBuilder,
    String startAnimation,
  }) {
    return SplashScreen(
      name,
      null,
      until: until,
      backgroundColor: backgroundColor,
      loopAnimation: loopAnimation,
      startAnimation: startAnimation,
      isLoading: isLoading,
      endAnimation: endAnimation,
      width: width,
      height: height,
      transitionsBuilder: transitionsBuilder,
      onFinished: onFinished,
      alignment: alignment,
    );
  }

  factory SplashScreen.navigate({
    @required String name,
    @required Widget next,
    Key key,
    bool isLoading,
    Color backgroundColor,
    Future Function() until,
    String loopAnimation,
    Alignment alignment = Alignment.center,
    double width,
    double height,
    String endAnimation,
    RoutePageBuilder transitionsBuilder,
    String startAnimation,
  }) {
    return SplashScreen(
      name,
      next,
      until: until,
      backgroundColor: backgroundColor,
      isLoading: isLoading,
      loopAnimation: loopAnimation,
      startAnimation: startAnimation,
      endAnimation: endAnimation,
      width: width,
      height: height,
      transitionsBuilder: transitionsBuilder,
      onFinished: null,
      alignment: alignment,
    );
  }

  const SplashScreen(
    this.name,
    this.next, {
    this.loopAnimation,
    Key key,
    this.isLoading,
    this.backgroundColor,
    this.until,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.transitionsBuilder,
    this.endAnimation,
    this.startAnimation,
    this.onFinished,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: FlareLoading(
        endAnimation: endAnimation,
        startAnimation: startAnimation,
        loopAnimation: loopAnimation,
        width: width,
        height: height,
        onFinished: () {
          _goToNext(context);
        },
        name: name,
        alignment: alignment,
        until: until,
        isLoading: isLoading,
      ),
    );
  }

  _goToNext(BuildContext context) {
    if (next == null) {
      onFinished();
    } else {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (_, __, ___) => next,
          transitionsBuilder: transitionsBuilder == null
              ? (_, Animation<double> animation, __, Widget child) {
                  return FadeTransition(opacity: animation, child: child);
                }
              : transitionsBuilder,
        ),
      );
    }
  }
}
