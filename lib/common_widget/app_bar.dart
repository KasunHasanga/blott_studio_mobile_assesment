import 'package:flutter/material.dart';
import '../config/constants.dart';
import '../config/fonts.dart';
import '../config/theme/theme_service.dart';
import 'package:get/get.dart';

class MainAppBar extends StatelessWidget {
  const MainAppBar({
    super.key,
    this.excludeHeader = false,
    this.showBack = false,
    this.otherAction=const [],

    required this.title,
  });
  final bool excludeHeader;

  final bool showBack;
  final String title;
  final List<Widget> otherAction;


  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: false,
      excludeHeaderSemantics: true,
      title: Text(title,  style: AppFonts.styleWithGilroyMediumText(
          color:Theme.of(context).colorScheme.onSurface,fSize: FontSizeValue.fontSize16),),


      backgroundColor: Theme.of(context).colorScheme.background,
    );}


  }

