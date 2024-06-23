import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/theme/constant/app_icons.dart';
import '../../../../../core/theme/custom/custom_app_bar.dart';
import '../../../../../core/theme/custom/custom_font_weight.dart';
import '../../cubit/mall_typ_cubit.dart';
import 'widgets/svg_icon_button.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 400),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: state.theme.backgroundColor,
          child: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 86,
            leading: SvgIconButton(
              icon: AppIcons.mainLogo,
              color: state.theme.logoColor,
              padding: 8,
            ),
            centerTitle: true,
            title: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(CustomAppBarTheme.tabBarRadius),
                ),
                color: state.theme.containerColor,
              ),
              child: SizedBox(
                height: 28,
                child: DefaultTabController(
                  initialIndex: state.index,
                  length: MallType.values.length,
                  child: TabBar(
                    onTap: (index) =>
                        context.read<MallTypeCubit>().changeIndex(index),
                    labelColor: state.theme.labelColor,
                    labelStyle: Theme.of(context).textTheme.labelLarge.bold,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    unselectedLabelColor: state.theme.unselectedLabelColor,
                    dividerColor: Colors.transparent,
                    tabs: List.generate(
                      MallType.values.length,
                      (index) => Text(MallType.values[index].toName),
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(CustomAppBarTheme.tabBarRadius),
                      ),
                      color: state.theme.indicatorColor,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: false,
                  ),
                ),
              ),
            ),
            actions: [
              SvgIconButton(
                icon: AppIcons.location,
                color: state.theme.iconColor,
                padding: 4,
              ),
              SvgIconButton(
                icon: AppIcons.cart,
                color: state.theme.iconColor,
                padding: 4,
              ),
            ],
          ),
        );
      },
    );
  }
}
