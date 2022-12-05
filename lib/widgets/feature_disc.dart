import 'package:flutter/material.dart';

import 'package:feature_discovery/feature_discovery.dart';
import 'package:niku/namespace.dart' as n;

class FeatureDisc extends StatelessWidget {

  const FeatureDisc({
    super.key,
    required this.id,
    required this.above,
    required this.backgroundColor,
    required this.child,
    required this.title,
    required this.description,
    this.icon
  });

  final bool above;
  final Color backgroundColor;
  final Widget child;
  final String id;
  final String title;
  final String description;
  final IconData? icon;

  @override
  Widget build(context) =>
    DescribedFeatureOverlay(
      featureId: id,
      textColor: Colors.white,
      backgroundColor: backgroundColor,
      contentLocation: above ? ContentLocation.above : ContentLocation.below,
      title: n.Text(title)
        ..fontSize = 20,
      pulseDuration: const Duration(seconds: 1),
      enablePulsingAnimation: true,
      openDuration: const Duration(milliseconds: 500),
      description: n.Text(description),
      tapTarget: icon != null ? Icon(icon, color: Colors.black) : Container(),
      child: child
    );
}
