import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../config/fonts.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    this.showBack = false,
    this.otherAction = const [],
    required this.title,
  });

  final bool showBack;
  final String title;
  final List<Widget> otherAction;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      surfaceTintColor: Colors.transparent,
      title: Text(
        title,
        style: AppFonts.styleWithRobotoMediumText(
            color: Theme.of(context).colorScheme.onSurface,
            fSize: FontSizeValue.fontSize16),
      ),
      actions: otherAction,
      backgroundColor: Theme.of(context).colorScheme.background,
    );
  }
}
