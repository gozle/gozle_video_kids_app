import 'package:flutter/material.dart';

class TemporaryTryAgain extends StatelessWidget {
  const TemporaryTryAgain({
    super.key,
    required this.onTap,
  });
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          'try again',
        ),
      ),
    );
  }
}
