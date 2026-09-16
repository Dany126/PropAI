import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;

  const ResponsiveLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.9,
          minHeight: MediaQuery.of(context).size.height * 0.9,
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: child,
      ),
    );
  }
}
