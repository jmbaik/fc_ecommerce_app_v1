import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/theme/constant/app_icons.dart';
import '../../../../../core/theme/custom/custom_theme.dart';
import '../../cubit/mall_typ_cubit.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MallTypeCubit, MallType>(
      builder: (_, state) {
        return AnimatedContainer(
          duration: Duration(milliseconds: 400),
          color: (state.isMarket)
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.background,
          padding: EdgeInsets.symmetric(vertical: 6, horizontal: 8),
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
            title: DefaultTabController(
              initialIndex: state.index,
              length: MallType.values.length,
              child: TabBar(
                onTap: (index) =>
                    context.read<MallTypeCubit>().changeIndex(index),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.black,
                tabs: List.generate(MallType.values.length,
                    (index) => Text(MallType.values[index].toName)),
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
