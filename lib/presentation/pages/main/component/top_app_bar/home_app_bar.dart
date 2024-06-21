import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/constant/app_icons.dart';
import '../../../../../core/theme/custom/custom_font_weight.dart';
import '../../../../../core/theme/custom/custom_theme.dart';
import '../../cubit/mall_typ_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 400),
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
          color: (state.isMarket)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          child: AppBar(
            backgroundColor: Colors.transparent,
            leadingWidth: 86,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppIcons.mainLogo,
                colorFilter: ColorFilter.mode(
                    state.isMarket
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.primary,
                    BlendMode.srcIn),
              ),
            ),
            centerTitle: true,
            title: AnimatedContainer(
              duration: Duration(milliseconds: 400),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(30),
                ),
                color: state.isMarket
                    ? colorScheme.primaryContainer
                    : colorScheme.surface,
              ),
              child: SizedBox(
                height: 28,
                child: DefaultTabController(
                  initialIndex: state.index,
                  length: MallType.values.length,
                  child: TabBar(
                    onTap: (index) =>
                        context.read<MallTypeCubit>().changeIndex(index),
                    labelColor: state.isMarket
                        ? colorScheme.primary
                        : colorScheme.background,
                    labelStyle: Theme.of(context).textTheme.labelLarge.bold,
                    labelPadding: const EdgeInsets.symmetric(horizontal: 12),
                    unselectedLabelColor: state.isMarket
                        ? colorScheme.background
                        : colorScheme.contentPrimary,
                    dividerColor: Colors.transparent,
                    tabs: List.generate(
                      MallType.values.length,
                      (index) => Text(MallType.values[index].toName),
                    ),
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: state.isMarket
                          ? colorScheme.background
                          : colorScheme.primary,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    isScrollable: false,
                  ),
                ),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppIcons.location,
                  colorFilter: ColorFilter.mode(
                      state.isMarket
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.contentPrimary,
                      BlendMode.srcIn),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: SvgPicture.asset(
                  AppIcons.cart,
                  colorFilter: ColorFilter.mode(
                      state.isMarket
                          ? Theme.of(context).colorScheme.background
                          : Theme.of(context).colorScheme.contentPrimary,
                      BlendMode.srcIn),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
