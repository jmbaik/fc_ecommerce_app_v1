import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/constant/app_icons.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.primary,
      padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
      child: AppBar(
        backgroundColor: Colors.transparent,
        leadingWidth: 86,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SvgPicture.asset(AppIcons.mainLogo),
        ),
        centerTitle: true,
        title: Text(
          'tabBar',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              AppIcons.location,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.background, BlendMode.srcIn),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: SvgPicture.asset(
              AppIcons.cart,
              colorFilter: ColorFilter.mode(
                  Theme.of(context).colorScheme.background, BlendMode.srcIn),
            ),
          )
        ],
      ),
    );
  }
}
